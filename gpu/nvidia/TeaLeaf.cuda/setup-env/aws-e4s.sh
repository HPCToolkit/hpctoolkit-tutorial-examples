# configure default setup for users
export HPCTOOLKIT_TUTORIAL_PROJECTID=default
export HPCTOOLKIT_TUTORIAL_RESERVATION=default

export QA_TEST_VARIANT=".cuda"

if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'ntrain' for training accounts"
  echo "    'default' to run with your default repository, which won't let you use the  reservation"
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

  module load cuda/12.2.0-ayvf4gp
  module load hpctoolkit/2024.01.1-cuda

  export QA_TEST_VARIANT=.cuda

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/2024.01.1-cuda"

  # environment settings for this example
  export HPCTOOLKIT_CUDA_ARCH=75
  export HPCTOOLKIT_TEA_MODULES_BUILD="source /usr/share/modules/init/sh"
  export HPCTOOLKIT_TEA_SUBMIT="qsub -V -l nodes=2:ppn=2,walltime=10:00"
  export HPCTOOLKIT_TEA_RUN="$HPCTOOLKIT_TEA_SUBMIT -o log.run.out -e log.run.stderr"
  export HPCTOOLKIT_TEA_RUN_PC="bash"
  export HPCTOOLKIT_TEA_BUILD="bash"
  export HPCTOOLKIT_TEA_LAUNCH="mpiexec "
  export HPCTOOLKIT_TEA_ROOT=$PWD

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=TeaLeaf
fi
