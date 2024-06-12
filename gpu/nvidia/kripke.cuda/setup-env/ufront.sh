# load modules needed to build and run kripke
module use /projects/modulefiles
module use /usr/local/modules
# module load cuda/11.8
# module load cmake

export QA_TEST_VARIANT=".cuda"

export CMAKE_COMMON_OPTIONS="\
    -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_CXX_STANDARD=17 \
	"

# export RAJA_COMPILER="RAJA_COMPILER_CLANG"
# export CMAKE_C_COMPILER="clang"
# export CMAKE_CXX_COMPILER="clang++"
# export CMAKE_CXX_FLAGS_RELWITHDEBINFO="-O3 -g -ffast-math"
# export ENABLE_CHAI="ON"
# export ENABLE_CUDA="ON"
# export ENABLE_OPENMP="OFF"
# export ENABLE_MPI="OFF"
# 
# export CMAKE_CUDA_ARCHITECTURES="80"
# export CMAKE_CUDA_FLAGS="-restrict -gencode=arch=compute_80,code=sm_80"

export KRIPKE_CONFIG=$KRIPKE_CONFIG_CUDA

# modules for hpctoolkit
export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/msi3 nvhpc/22.3"
$HPCTOOLKIT_MODULES_HPCTOOLKIT

# environment settings for this example
export HPCTOOLKIT_KRIPKE_ROOT="$(pwd)"
export HPCTOOLKIT_KRIPKE_MODULES_BUILD=""
export HPCTOOLKIT_KRIPKE_SUBMIT="sh"
export HPCTOOLKIT_KRIPKE_RUN="sh"
export HPCTOOLKIT_KRIPKE_RUN_PC="sh"
export HPCTOOLKIT_KRIPKE_BUILD="sh"
export HPCTOOLKIT_KRIPKE_OMP_NUM_THREADS=1
export HPCTOOLKIT_KRIPKE_LAUNCH="mpirun -n1"

# mark configuration for this example
export HPCTOOLKIT_EXAMPLE=Kripke$QA_TEST_VARIANT
