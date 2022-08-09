export HPCTOOLKIT_TUTORIAL_PROJECTID=default
export HPCTOOLKIT_TUTORIAL_RESERVATION=default

if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
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

  # load hpctoolkit modules
  module load hpctoolkit/2022.08.03
  module use /soft/perftools/hpctoolkit/theta-gpu-2022.05/modules/linux-ubuntu20.04-x86_64/Core
  module load cuda

  # modules for hpctoolkit
  #export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/2022.08.03"
  export HPCTOOLKIT_BIN=`basename hpcrun`
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="export PATH=$PATH"
  #export NVCC=`which nvcc`
  #export NVCC_HOME=`dirname $NVCC`
  #export CUDA_HOME=`dirname $NVCC_HOME`

  # environment settings for this example
  export HPCTOOLKIT_CUDA_ARCH=80
  export HPCTOOLKIT_QS_MODULES_BUILD="module load cuda"
  export HPCTOOLKIT_QS_MODULES_BUILD="export PATH=$PATH"
  export HPCTOOLKIT_QS_SUBMIT="sh"
  export HPCTOOLKIT_QS_RUN="sh"
  export HPCTOOLKIT_QS_RUN_PC="sh"
  export HPCTOOLKIT_QS_BUILD="sh"
  export HPCTOOLKIT_QS_LAUNCH=""

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=quicksilver
fi
