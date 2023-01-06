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
    export HPCTOOLKIT_PROJECTID="-A ${HPCTOOLKIT_TUTORIAL_PROJECTID}_crusher"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="--reservation=$HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  # Cleanse environment
  module purge

  # load modules needed to build and run pelec
  module load PrgEnv-cray rocm cmake openblas craype-x86-trento

  # modules for hpctoolkit
  module use /gpfs/alpine/csc322/world-shared/modulefiles/x86_64
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/latest"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=amd
  export HPCTOOLKIT_MINIQMC_MODULES_BUILD=""
  export HPCTOOLKIT_MINIQMC_GPUFLAGS="-DENABLE_OFFLOAD=1 -DOFFLOAD_TARGET=amdgcn-amd-amdhsa -DOFFLOAD_ARCH=gfx90a -DQMC_MIXED_PRECISION=ON"
  export HPCTOOLKIT_MINIQMC_CXX_COMPILER=crayCC
  export HPCTOOLKIT_MINIQMC_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -N 1 -c 64 -t 10"
  export HPCTOOLKIT_MINIQMC_RUN="$HPCTOOLKIT_MINIQMC_SUBMIT -J miniqmc-run -o log.run.out -e log.run.error -G 1"
  export HPCTOOLKIT_MINIQMC_RUN_PC="sh make-scripts/unsupported-amd.sh"
  export HPCTOOLKIT_MINIQMC_BUILD="sh"
  export HPCTOOLKIT_MINIQMC_LAUNCH="srun -n 1 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=miniqmc
fi
