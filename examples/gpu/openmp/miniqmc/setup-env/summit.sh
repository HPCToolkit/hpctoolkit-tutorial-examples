if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your projec
t id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an approp
riate value:"
  echo "    'hpctoolkit1' for day 1"
  echo "    'hpctoolkit2' for day 2"
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

  # load hpctoolkit modules
  module use /gpfs/alpine/csc322/world-shared/modulefiles/ppc64le
  module load hpctoolkit/master-202208-papi

  module load nvhpc
  module load cuda/11.5.2
  module load essl
  module load netlib-lapack
  module load cmake
  module load spectrum-mpi

  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_MINIQMC_CXX_COMPILER="nvc++"
  export HPCTOOLKIT_MINIQMC_CXXFLAGS="-DENABLE_OFFLOAD=1"
  export HPCTOOLKIT_MINIQMC_BUILD="sh"
  export HPCTOOLKIT_MINIQMC_LAUNCH="jsrun -n 1 -g 1 -a 1 -c 11 -brs"
  export HPCTOOLKIT_MINIQMC_RUN="bsub -P $HPCTOOLKIT_TUTORIAL_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION -J miniqmc-run -o log.run.out -e log.run.error $1"
  export HPCTOOLKIT_MINIQMC_RUN_PC="bsub -P $HPCTOOLKIT_TUTORIAL_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION -J miniqmc-run-pc -o log.run-pc.out -e log.run-pc.error $1"

  export HPCTOOLKIT_EXAMPLE=miniqmc
fi
