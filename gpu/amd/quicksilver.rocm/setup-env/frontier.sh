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
  
  # cleanse environment
  module purge

  # load modules needed to build and run quicksilver
  module load Core/24.07 PrgEnv-amd amd/5.7.1 rocm/5.7.1 cray-mpich cmake craype-x86-trento craype-accel-amd-gfx90a

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load Core/24.07 hpctoolkit"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # compiler flags for this example
  export HPCTOOLKIT_QS_CXX=mpicxx
  export HPCTOOLKIT_QS_CXXFLAGS=-g
  export HPCTOOLKIT_QS_CPPFLAGS="-DHAVE_MPI -DHAVE_HIP -x hip --offload-arch=gfx90a -fgpu-rdc -Wno-unused-result"
  export HPCTOOLKIT_QS_ROCM_LDFLAGS="-fgpu-rdc --hip-link --offload-arch=gfx90a"


  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=amd
  export HPCTOOLKIT_QS_ROOT="$(pwd)"
  export HPCTOOLKIT_QS_MODULES_BUILD=""
  export HPCTOOLKIT_QS_GPU_ARCH="-DKokkos_ARCH_VEGA90A=ON"
  export HPCTOOLKIT_QS_HOST_ARCH=""
  export HPCTOOLKIT_QS_GPUFLAGS="-DCMAKE_CXX_COMPILER=$(which hipcc) -DCMAKE_CXX_FLAGS=\"-g\""
  export HPCTOOLKIT_QS_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 20 -N 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_QS_RUN="$HPCTOOLKIT_QS_SUBMIT -J qsilver-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_QS_RUN_PC="sh make-scripts/unsupported-amd.sh"
  export HPCTOOLKIT_QS_BUILD="sh"
  export HPCTOOLKIT_QS_OMP_NUM_THREADS=7
  export HPCTOOLKIT_QS_LAUNCH="srun --ntasks=8 --ntasks-per-node=8 --gpus-per-task=1 --gpu-bind=closest -c 7"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=quicksilver

fi
