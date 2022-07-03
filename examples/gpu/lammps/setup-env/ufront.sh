# configure default setup for users
export HPCTOOLKIT_TUTORIAL_PROJECTID=default
export HPCTOOLKIT_TUTORIAL_RESERVATION=default

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
  module use /usr/local/modules
  module use /home/johnmc/modules

  module use /projects/modulefiles
  module load openmpi/4.1.2

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/opencl"

  # environment settings for this example
  export HPCTOOLKIT_CUDA_ARCH=80
  #export HPCTOOLKIT_LAMMPS_GPU_ARCH="-DKokkos_ARCH_GPUARCH=VOLTA70 -DKokkos_ARCH_VOLTA70=ON"
  #export HPCTOOLKIT_LAMMPS_HOST_ARCH="-DKokkos_ARCH_HOSTARCH=POWER9"
  export HPCTOOLKIT_LAMMPS_GPU_ARCH="-DKokkos_ARCH_GPUARCH=AMPERE80 -DKokkos_ARCH_AMPERE80=ON"
  export HPCTOOLKIT_LAMMPS_HOST_ARCH="-DKokkos_ARCH_HOSTARCH=x86_64"
  export HPCTOOLKIT_LAMMPS_MODULES_BUILD="module load openmpi/4.1.2 cuda/11.6"
  export HPCTOOLKIT_LAMMPS_SUBMIT="sh"
  export HPCTOOLKIT_LAMMPS_RUN="sh"
  export HPCTOOLKIT_LAMMPS_RUN_PC="sh"
  export HPCTOOLKIT_LAMMPS_BUILD="sh"
  export HPCTOOLKIT_LAMMPS_LAUNCH="mpiexec -n 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=lammps
fi
