if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-A ${HPCTOOLKIT_TUTORIAL_PROJECTID}"
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

  # load modules needed to build and run miniqmc
  module load PrgEnv-amd amd/5.4.3 cray-mpich cmake craype-x86-trento craype-accel-amd-gfx90a

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load ums ums023 hpctoolkit"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=amd
  export HPCTOOLKIT_MINIQMC_ROOT="$(pwd)"
  export HPCTOOLKIT_MINIQMC_GPUFLAGS="-DENABLE_OFFLOAD=1 -DOFFLOAD_TARGET=amdgcn-amd-amdhsa -DOFFLOAD_ARCH=gfx90a -DQMC_MPI=ON -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment -DQMC_MIXED_PRECISION=ON"
  export HPCTOOLKIT_MINIQMC_CXX_COMPILER=CC
  export HPCTOOLKIT_MINIQMC_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -N 1 -t 30"
  export HPCTOOLKIT_MINIQMC_RUN="$HPCTOOLKIT_MINIQMC_SUBMIT -J miniqmc-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_MINIQMC_RUN_PC="sh make-scripts/unsupported-amd.sh"
  export HPCTOOLKIT_MINIQMC_BUILD="sh"
  export HPCTOOLKIT_MINIQMC_LAUNCH="srun -n 8 --ntasks-per-node=8 --cpus-per-task=7 --gpus-per-task=1 --gpu-bind=closest"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=miniqmc
fi
