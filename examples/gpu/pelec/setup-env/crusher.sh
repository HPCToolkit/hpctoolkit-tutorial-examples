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

  # load modules needed to build and run pelec
  module load PrgEnv-cray cce/14.0.3 rocm/5.2.0 cray-mpich craype-x86-trento craype-accel-amd-gfx90a cmake

  # modules for hpctoolkit
  module use /gpfs/alpine/csc322/world-shared/modulefiles/x86_64
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=amd
  export HPCTOOLKIT_PELEC_GPU_PLATFORM=hip
  export HPCTOOLKIT_PELEC_MODULES_BUILD=""
  export HPCTOOLKIT_PELEC_GPUFLAGS="-DENABLE_HIP=ON -DPELEC_ENABLE_HIP=ON -DAMReX_AMD_ARCH=gfx90a"
  export HPCTOOLKIT_PELEC_CXX_COMPILER=crayCC
  export HPCTOOLKIT_PELEC_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 10 -N 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_PELEC_RUN="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_PELEC_RUN_PC="sh make-scripts/unsupported-amd.sh"
  export HPCTOOLKIT_PELEC_BUILD="sh"
  export HPCTOOLKIT_PELEC_LAUNCH="srun -n 1 -c 1 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=pelec

fi
