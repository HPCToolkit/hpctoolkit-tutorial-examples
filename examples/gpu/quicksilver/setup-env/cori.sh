if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'm3502' for cori users"
  echo "    'ntrain' for training accounts"
  echo "    'default' to run with your default repository, which won't let you use the  reservation"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'hpc1_gpu' for day 1"
  echo "    'hpc2_gpu' for day 2"
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

  # load hpctoolkit modules
  module use /global/common/software/m3977/hpctoolkit/2021-11/modules
  module load hpctoolkit/2021.11-gpu

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/2021.11-gpu"

  # environment settings for this example
  export HPCTOOLKIT_QS_MODULES_BUILD="module load cuda/11.1.1 cmake gcc"
  export HPCTOOLKIT_QS_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -N 1 -c 10 -C gpu -t 10"
  export HPCTOOLKIT_QS_RUN="$HPCTOOLKIT_QS_SUBMIT -J qs-run -o log.run.out -e log.run.stderr -G 1"
  export HPCTOOLKIT_QS_RUN_PC="$HPCTOOLKIT_QS_SUBMIT -J qs-run-pc -o log.run-pc.out -e log.run-pc.stderr -G 1"
  export HPCTOOLKIT_QS_BUILD="$HPCTOOLKIT_QS_SUBMIT -J qs-build -o log.build.out -e log.build.stderr"
  export HPCTOOLKIT_QS_LAUNCH="srun -n 1 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=quicksilver
fi
