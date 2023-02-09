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

  # load modules needed to build and run lulesh
  module load PrgEnv-amd amd/5.4.0 craype-x86-trento craype-accel-amd-gfx90a

  # modules for hpctoolkit
  module use /gpfs/alpine/csc322/world-shared/modulefiles/x86_64
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=amd
  export HPCTOOLKIT_LULESH_OMP_MODULES_BUILD=""
  export HPCTOOLKIT_LULESH_OMP_CXX=amdclang++
  export HPCTOOLKIT_LULESH_OMP_OMPFLAGS="-fopenmp -fopenmp-targets=amdgcn-amd-amdhsa -Xopenmp-target=amdgcn-amd-amdhsa -march=gfx90a"
  export HPCTOOLKIT_LULESH_OMP_CXXFLAGS="-DUSE_MPI=0 -g -O2 ${HPCTOOLKIT_LULESH_OMP_OMPFLAGS}"
  export HPCTOOLKIT_LULESH_OMP_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 5 -N 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LULESH_OMP_RUN="$HPCTOOLKIT_LULESH_OMP_SUBMIT -J lulesh-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_LULESH_OMP_RUN_PC="sh make-scripts/unsupported-amd.sh"
  export HPCTOOLKIT_LULESH_OMP_BUILD="sh"
  export HPCTOOLKIT_LULESH_OMP_LAUNCH="srun -n 1 -c 1 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=luleshomp

fi
