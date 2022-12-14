export HPCTOOLKIT_TUTORIAL_RESERVATION=default

if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'ntrain' for training accounts"
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
    export HPCTOOLKIT_RESERVATION="--reservation=$HPCTOOLKIT_TUTORIAL_RESERVATION -q shared"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  # set up your environment to use cori's gpu nodes
  module purge
  module load cgpu

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT
  module load hpcviewer

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_PELEC_GPU_PLATFORM=cuda
  export HPCTOOLKIT_PELEC_MODULES_BUILD="module load gcc python cuda/11.4.0 openmpi cmake"
  export HPCTOOLKIT_PELEC_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -N 1 -c 10 -C gpu -t 10"
  export HPCTOOLKIT_PELEC_RUN="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run -o log.run.out -e log.run.error -G 1"
  export HPCTOOLKIT_PELEC_RUN_PC="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run-pc -o log.run-pc.out -e log.run-pc.error -G 1"
  export HPCTOOLKIT_PELEC_BUILD="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-build -o log.build.out -e log.build.error"
  export HPCTOOLKIT_PELEC_LAUNCH="srun -n 1 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=pelec
fi
