export HPCTOOLKIT_TUTORIAL_RESERVATION=default

if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-A $HPCTOOLKIT_TUTORIAL_PROJECTID"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="-q $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    # If no reservation is set, use the debug queue
    export HPCTOOLKIT_RESERVATION="-q debug"
  fi

  # cleanse environment
  module reset

  # load modules needed to build and run pelec
  module load PrgEnv-gnu cmake craype-x86-milan cray-mpich cudatoolkit-standalone/11.4.4
  unset CUDA_HOME NVHPC_CUDA_HOME
  export CUDA_HOME=/soft/compilers/cudatoolkit/cuda-11.4.4

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /soft/perftools/hpctoolkit/polaris/modulefiles"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_PELEC_ROOT="$(pwd)"
  export HPCTOOLKIT_PELEC_GPU_PLATFORM=cuda
  export HPCTOOLKIT_PELEC_MODULES_BUILD=""
  export HPCTOOLKIT_PELEC_GPUFLAGS="-DENABLE_CUDA=ON -DPELEC_ENABLE_CUDA=ON -DAMReX_CUDA_ARCH=8.0"
  export HPCTOOLKIT_PELEC_CXX_COMPILER=g++
  export HPCTOOLKIT_PELEC_SUBMIT="qsub $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -l select=1 -l walltime=0:15:00 -l filesystems=home:grand:eagle -V"
  export HPCTOOLKIT_PELEC_RUN="$HPCTOOLKIT_PELEC_SUBMIT -N pelec-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_PELEC_RUN_PC="$HPCTOOLKIT_PELEC_SUBMIT -N pelec-run-pc -o log.run-pc.out -e log.run-pc.error"
  export HPCTOOLKIT_PELEC_BUILD="sh"
  export HPCTOOLKIT_PELEC_LAUNCH="mpiexec -n 4 -ppn 4 --depth=8 --cpu-bind depth sh ../make-scripts/set_affinity_gpu_polaris.sh"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=pelec
fi
