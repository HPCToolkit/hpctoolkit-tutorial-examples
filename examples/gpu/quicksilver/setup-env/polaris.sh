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
    export HPCTOOLKIT_PROJECTID="-A $HPCTOOLKIT_TUTORIAL_PROJECTID"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="-q $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_PROJECTID
  fi

  # cleanse environment
  module reset

  # load modules needed to build and run quicksilver
  module load PrgEnv-gnu cmake craype-x86-milan cudatoolkit-standalone/11.8.0
  export CUDA_HOME=/soft/compilers/cudatoolkit/cuda-11.8.0
i
  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /soft/perftools/hpctoolkit/polaris/modulefiles"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_MPI_CXX=CC
  export HPCTOOLKIT_CUDA_ARCH=80
  export HPCTOOLKIT_QS_ROOT="$(pwd)"
  export HPCTOOLKIT_QS_MODULES_BUILD=""
  export HPCTOOLKIT_QS_SUBMIT="qsub $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -l select=1 -l walltime=0:10:00 -l filesystems=home:grand -V"
  export HPCTOOLKIT_QS_RUN="$HPCTOOLKIT_QS_SUBMIT -N qs-run -o log.run.out -e log.run.stderr"
  export HPCTOOLKIT_QS_RUN_PC="$HPCTOOLKIT_QS_SUBMIT -N qs-run-pc -o log.run-pc.out -e log.run-pc.stderr"
  export HPCTOOLKIT_QS_BUILD="sh"
  export HPCTOOLKIT_QS_LAUNCH="mpiexec -n 4 -ppn 4 --depth=8 --cpu-bind depth sh make-scripts/set_affinity_gpu_polaris.sh"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=quicksilver
fi
