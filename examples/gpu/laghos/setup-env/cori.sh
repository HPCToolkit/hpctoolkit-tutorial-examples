# configure default setup for users
export HPCTOOLKIT_TUTORIAL_PROJECTID=default
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

  # load hpctoolkit modules
  module use /global/common/software/m3977/hpctoolkit/2021-11/modules
  module load hpctoolkit/2021.11-gpu

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/2021.11-gpu"

  # set platform
  unset HPCTOOLKIT_TUTORIAL_GPU_PLATFORM
  export HPCTOOLKIT_TUTORIAL_GPU_PLATFORM=cori

  # environment settings for this example
  export HPCTOOLKIT_LAGHOS_MODULES_BUILD=" module load cuda/11.3.0 cmake/3.21.3 gcc openmpi"
  export HPCTOOLKIT_LAGHOS_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -N 1 -c 10 -C gpu -t 20"
  export HPCTOOLKIT_LAGHOS_RUN_SHORT="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-short -o log.run-short.out -e log.run-short.error -G 1"
  export HPCTOOLKIT_LAGHOS_RUN_LONG="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-long -o log.run-long.out -e log.run-long.error -G 1"
  export HPCTOOLKIT_LAGHOS_RUN_PC="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-pc -o log.run-pc.out -e log.run-pc.error -G 1"
  export HPCTOOLKIT_LAGHOS_BUILD="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-build -o log.build.out -e log.build.error"
  export HPCTOOLKIT_LAGHOS_LAUNCH="srun -n 1 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=laghos
fi
