if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'default' to run with your default repository, which won't let you use the reservation"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-A ${HPCTOOLKIT_TUTORIAL_PROJECTID}"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="-q ${HPCTOOLKIT_TUTORIAL_RESERVATION}"
  else
    # If no reservation is set, use the debug queue
    export HPCTOOLKIT_RESERVATION="-q debug"
  fi

  # cleanse environment
  module reset

  # load modules needed to build and run laghos
  module load PrgEnv-gnu cmake craype-x86-milan cudatoolkit-standalone/11.8.0
  export CUDA_HOME=/soft/compilers/cudatoolkit/cuda-11.8.0

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /soft/perftools/hpctoolkit/polaris/modulefiles"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_CUDA_ARCH=80
  export HPCTOOLKIT_MPI_CC=cc
  export HPCTOOLKIT_MPI_CXX=CC
  export HPCTOOLKIT_LAGHOS_ROOT="$(pwd)"
  export HPCTOOLKIT_LAGHOS_MODULES_BUILD=""
  export HPCTOOLKIT_LAGHOS_C_COMPILER=gcc
  export HPCTOOLKIT_LAGHOS_MFEM_FLAGS="pcuda CUDA_ARCH=sm_$HPCTOOLKIT_CUDA_ARCH BASE_FLAGS='-std=c++11 -g'"
  export HPCTOOLKIT_LAGHOS_SUBMIT="qsub $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -l select=1 -l walltime=0:20:00 -l filesystems=home:grand -V"
  export HPCTOOLKIT_LAGHOS_RUN_SHORT="$HPCTOOLKIT_LAGHOS_SUBMIT -N laghos-run-short -o log.run-short.out -e log.run-short.error"
  export HPCTOOLKIT_LAGHOS_RUN_LONG="$HPCTOOLKIT_LAGHOS_SUBMIT -N laghos-run-long -o log.run-long.out -e log.run-long.error"
  export HPCTOOLKIT_LAGHOS_RUN_PC="$HPCTOOLKIT_LAGHOS_SUBMIT -N laghos-run-pc -o log.run-pc.out -e log.run-pc.error"
  export HPCTOOLKIT_LAGHOS_BUILD="sh"
  export HPCTOOLKIT_LAGHOS_LAUNCH="mpiexec -n 4 -ppn 4 --depth=8 --cpu-bind depth sh make-scripts/set_affinity_gpu_polaris.sh"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=laghos

fi
