# configure default setup for users
export HPCTOOLKIT_TUTORIAL_PROJECTID=default
export HPCTOOLKIT_TUTORIAL_RESERVATION=default

export QA_TEST_VARIANT=".rocm"

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

  # load hpctoolkit modules
  #module use /usr/local/modules
  #module use /opt/modules
  #module use /projects/modulefiles

  # modules for hpctoolkit
  # export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/msi3"


  # load modules needed to build and run quicksilver
  # module load rocm/6.2.0

  # modules for hpctoolkit
  # $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # compiler flags for this example
  export HPCTOOLKIT_QS_CXX=hipcc
  export HPCTOOLKIT_QS_CXXFLAGS=-g
  export HPCTOOLKIT_QS_CPPFLAGS="-DHAVE_HIP -x hip --offload-arch=gfx90a -fgpu-rdc -Wno-unused-result"
  export HPCTOOLKIT_QS_ROCM_LDFLAGS="-fgpu-rdc --hip-link --offload-arch=gfx90a"


  # environment settings for this example
  # export HPCTOOLKIT_CUDA_ARCH=80
  export HPCTOOLKIT_QS_MODULES_BUILD=
  export HPCTOOLKIT_QS_SUBMIT="sh"
  export HPCTOOLKIT_QS_RUN="sh"
  export HPCTOOLKIT_QS_RUN_PC="sh"
  export HPCTOOLKIT_QS_BUILD="sh"
  export HPCTOOLKIT_QS_LAUNCH="sh"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=quicksilver
fi
