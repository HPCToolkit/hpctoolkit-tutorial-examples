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

  module purge
  module load hpctoolkit/2021.03.01
  module load xl
  module load cuda/10.1.243
  module load essl
  module load netlib-lapack
  module load cmake/3.17.3
  module load spectrum-mpi

  export HPCTOOLKIT_MINIQMC_CXX="xlC_r"
  export HPCTOOLKIT_MINIQMC_CXXFLAGS=""
  export HPCTOOLKIT_MINIQMC_COMPILER_FLAGS="-DCMAKE_CXX_COMPILER_ID='XL'"
  export HPCTOOLKIT_MINIQMC_BUILD="sh"
  export HPCTOOLKIT_MINIQMC_LAUNCH="jsrun -n 1 -g 1 -a 1 -c 11 -brs"
  export HPCTOOLKIT_MINIQMC_RUN="bsub -P $HPCTOOLKIT_TUTORIAL_PROJECTID -W 5 -nnodes 1 $RESERVE -J miniqmc-run -o log.run.out -e log.run.error $1"

  unset HPCTOOLKIT_TUTORIAL_GPU_LAMMMPS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY

  export HPCTOOLKIT_TUTORIAL_BATCH=1
  export HPCTOOLKIT_TUTORIAL_CPU_MINIQMC_READY=1
fi
