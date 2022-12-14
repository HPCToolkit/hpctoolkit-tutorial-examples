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

  # load modules needed to build and run pelec
  module load gcc python cuda/11.5.2 spectrum-mpi cmake

  # modules for hpctoolkit
  module use /gpfs/alpine/csc322/world-shared/modulefiles/ppc64le
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_PELEC_GPU_PLATFORM=cuda
  export HPCTOOLKIT_PELEC_MODULES_BUILD=""
  export HPCTOOLKIT_PELEC_SUBMIT="bsub $HPCTOOLKIT_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_PELEC_RUN="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run -o log.run.out -e log.run.error -G 1"
  export HPCTOOLKIT_PELEC_RUN_PC="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run-pc -o log.run-pc.out -e log.run-pc.error -G 1"
  export HPCTOOLKIT_PELEC_BUILD="sh"
  export HPCTOOLKIT_PELEC_LAUNCH="jsrun -n 1 -g 1 -a 1"
  export HPCTOOLKIT_PELEC_LAUNCH_ARGS="--smpiargs=\"-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks\""

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=pelec

fi
