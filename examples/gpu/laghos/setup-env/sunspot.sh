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
    export HPCTOOLKIT_PROJECTID="-A ${HPCTOOLKIT_TUTORIAL_PROJECTID}"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="-q $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    export HPCTOOLKIT_RESERVATION="-q workq"
  fi

  # cleanse environment
  module purge

  # load modules needed to build and run laghos
  module load oneapi spack cmake

  # modules for hpctoolkit
  module use /soft/perftools/hpctoolkit/modulefiles
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/latest"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=level0
  export HPCTOOLKIT_MPI_CC=mpicc
  export HPCTOOLKIT_MPI_CXX=mpicxx
  export HPCTOOLKIT_LAGHOS_MODULES_BUILD=""
  export HPCTOOLKIT_LAGHOS_C_COMPILER=icx
  export HPCTOOLKIT_LAGHOS_CXX_COMPILER=icpx
  export HPCTOOLKIT_LAGHOS_CXXFLAGS="-fsycl -std=c++17"
  export HPCTOOLKIT_LAGHOS_RAJA_BUILD=1
  export HPCTOOLKIT_LAGHOS_RAJA_VER=v2022.10.5
  export HPCTOOLKIT_LAGHOS_RAJA_ROOT=$(pwd)/laghos/RAJA-${HPCTOOLKIT_LAGHOS_RAJA_VER}
  export HPCTOOLKIT_LAGHOS_RAJA_FLAGS="-DRAJA_ENABLE_SYCL=ON -DENABLE_TESTS=OFF"
  export HPCTOOLKIT_LAGHOS_MFEM_FLAGS="parallel MFEM_USE_RAJA=YES RAJA_LIB=$HPCTOOLKIT_LAGHOS_RAJA_ROOT/lib BASE_FLAGS='-std=c++17 -g'"
  export HPCTOOLKIT_LAGHOS_SUBMIT="qsub $HPCTOOLKIT_PROJECTID -l walltime=00:15:00 -l select=1:system=sunspot -l filesystems=home -k doe $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LAGHOS_RUN_SHORT="$HPCTOOLKIT_LAGHOS_SUBMIT -N laghos-run-short -o log.run-short.out -e log.run-short.error"
  export HPCTOOLKIT_LAGHOS_RUN_LONG="$HPCTOOLKIT_LAGHOS_SUBMIT -N laghos-run-long -o log.run-long.out -e log.run-long.error"
  export HPCTOOLKIT_LAGHOS_RUN_PC="sh make-scripts/unsupported-pc.sh Intel"
  export HPCTOOLKIT_LAGHOS_RUN_COUNT="$HPCTOOLKIT_LAGHOS_SUBMIT -N laghos-run-inst-count -o log.run-inst-count.out -e log.run-inst-count.error"
  export HPCTOOLKIT_LAGHOS_BUILD="sh"
  export HPCTOOLKIT_LAGHOS_LAUNCH="mpirun -n 12"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=laghos

fi
