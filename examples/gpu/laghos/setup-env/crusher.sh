export HPCTOOLKIT_TUTORIAL_RESERVATION=default

if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
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

  # cleanse environment
  module purge

  # load modules needed to build and run laghos
  module load PrgEnv-amd amd/5.4.3 cray-mpich craype-x86-trento craype-accel-amd-gfx90a

  # modules for hpctoolkit
#  module use /gpfs/alpine/csc322/world-shared/modulefiles/x86_64
#  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/develop"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=amd
  export HPCTOOLKIT_HIP_ARCH=gfx90a
  export HPCTOOLKIT_MPI_CC=cc
  export HPCTOOLKIT_MPI_CXX=CC
  export HPCTOOLKIT_LAGHOS_MODULES_BUILD=""
  export HPCTOOLKIT_LAGHOS_C_COMPILER=amdclang
  export HPCTOOLKIT_LAGHOS_MFEM_FLAGS="phip HIP_ARCH=$HPCTOOLKIT_HIP_ARCH BASE_FLAGS='-std=c++11 -g'"
  export HPCTOOLKIT_LAGHOS_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 5 -N 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LAGHOS_RUN_SHORT="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-short -o log.run-short.out -e log.run-short.error"
  export HPCTOOLKIT_LAGHOS_RUN_LONG="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-long -o log.run-long.out -e log.run-long.error"
  export HPCTOOLKIT_LAGHOS_RUN_PC="sh make-scripts/unsupported-pc.sh AMD"
  export HPCTOOLKIT_LAGHOS_RUN_COUNT="sh make-scripts/unsupported-inst-count.sh"
  export HPCTOOLKIT_LAGHOS_BUILD="sh"
  export HPCTOOLKIT_LAGHOS_LAUNCH="srun -n 8 -c 1 --gpus-per-node=8 --gpu-bind=closest"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=laghos

fi
