export HPCTOOLKIT_TUTORIAL_RESERVATION=default

if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your projec
t id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an approp
riate value:"
#  echo "    'hpctoolkit1' for day 1"
#  echo "    'hpctoolkit2' for day 2"
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

  # load modules needed to build and run miniqmc
  module load nvhpc/22.11 cuda/11.5.2 cmake essl netlib-lapack

  # modules for hpctoolkit
  module use /gpfs/alpine/csc322/world-shared/modulefiles/ppc64le
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/2022.10.01"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_MINIQMC_CXX_COMPILER="nvc++"
  export HPCTOOLKIT_MINIQMC_CXXFLAGS="-DENABLE_OFFLOAD=1"
  export HPCTOOLKIT_MINIQMC_BUILD="sh"
  export HPCTOOLKIT_MINIQMC_LAUNCH="jsrun -n 1 -g 1 -a 1 -c 11 -brs"
  export HPCTOOLKIT_MINIQMC_LAUNCH_ARGS="--smpiargs \"-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks\""
  export HPCTOOLKIT_MINIQMC_RUN="bsub $HPCTOOLKIT_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION -J miniqmc-run -o log.run.out -e log.run.error $1"
  export HPCTOOLKIT_MINIQMC_RUN_PC="bsub $HPCTOOLKIT_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION -J miniqmc-run-pc -o log.run-pc.out -e log.run-pc.error $1"


  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=miniqmc
fi
