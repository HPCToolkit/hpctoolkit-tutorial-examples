HPCTOOLKIT_TUTORIAL_RESERVATION=default
if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
#  echo "    'hpctoolkit1' for day 1"
#  echo "    'hpctoolkit2' for day 2"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-P $HPCTOOLKIT_TUTORIAL_PROJECTID"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="-U $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  # cleanse environment
  module purge

  # load modules needed to build and run lulesh
  module load nvhpc cuda/11.5.2

  # modules for hpctoolkit
  module use /gpfs/alpine/csc322/world-shared/modulefiles/ppc64le
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/latest"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_LULESH_ACC_MODULES_BUILD=""
  export HPCTOOLKIT_LULESH_ACC_CXX="nvc++ -DUSE_MPI=0 -DSEDOV_SYNC_POS_VEL_LATE"
  export HPCTOOLKIT_LULESH_ACC_ACCFLAGS="-acc -Minfo=accel -fast -gopt"
  export HPCTOOLKIT_LULESH_ACC_CXXFLAGS="-mp --restrict -Mautoinline -Minline=levels:20 $HPCTOOLKIT_LULESH_ACC_ACCFLAGS"
  export HPCTOOLKIT_LULESH_ACC_SUBMIT="bsub $HPCTOOLKIT_PROJECTID -W 20 -nnodes 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LULESH_ACC_RUN="$HPCTOOLKIT_LULESH_ACC_SUBMIT -J lulesh-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_LULESH_ACC_RUN_PC="$HPCTOOLKIT_LULESH_ACC_SUBMIT -J lulesh-run-pc -o log.run-pc.out -e log.run-pc.error"
  export HPCTOOLKIT_LULESH_ACC_BUILD="sh"
  export HPCTOOLKIT_LULESH_ACC_LAUNCH="jsrun -n 1 -g 1 -a 1"
  export HPCTOOLKIT_LULESH_ACC_LAUNCH_ARGS="--smpiargs \"-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks\""

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=luleshacc

fi


