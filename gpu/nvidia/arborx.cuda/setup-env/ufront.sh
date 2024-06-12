# load modules needed to build and run arborx
module use /projects/modulefiles
module use /usr/local/modules
# module load cuda/11.8
# module load cmake

export QA_TEST_VARIANT=".cuda"

export CMAKE_COMMON_OPTIONS="\
    -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
    -DCMAKE_CXX_STANDARD=17"

export KOKKOS_CONFIG_CUDA="\
    $CMAKE_COMMON_OPTIONS \
    -DKokkos_ENABLE_CUDA=ON \
    -DCMAKE_CXX_COMPILER=g++ \
    -DKokkos_ARCH_AMPERE80=ON"

export KOKKOS_CONFIG=$KOKKOS_CONFIG_CUDA

export ARBORX_SRC=ArborX$QA_TEST_VARIANT/ArborX
export ARBORX_INSTALL_DIR=$ARBORX_SRC/install

export ARBORX_CONFIG_CUDA="\
    $CMAKE_COMMON_OPTIONS \
    -DKokkos_ENABLE_CUDA=ON \
    -DCMAKE_CXX_COMPILER=g++ \
    "

export ARBORX_CONFIG=$ARBORX_CONFIG_CUDA

export CMAKE_PREFIX_PATH="$ARBORX_INSTALL_DIR;$KOKKOS_INSTALL_DIR"

export OMP_PROC_BIND=spread
export OMP_PLACES=threads

# modules for hpctoolkit
export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/msi3"
$HPCTOOLKIT_MODULES_HPCTOOLKIT

# environment settings for this example
export HPCTOOLKIT_GPU_PLATFORM=nvidia
export HPCTOOLKIT_GPU_PLATFORM_PC=nvidia,pc
export HPCTOOLKIT_ARBORX_ROOT="$(pwd)"
export HPCTOOLKIT_ARBORX_MODULES_BUILD=""
export HPCTOOLKIT_ARBORX_GPU_ARCH="-DKokkos_ARCH_AMPERE80=ON"
export HPCTOOLKIT_ARBORX_SUBMIT="sh"
export HPCTOOLKIT_ARBORX_RUN="sh"
export HPCTOOLKIT_ARBORX_RUN_PC="sh"
export HPCTOOLKIT_ARBORX_BUILD="sh"
export HPCTOOLKIT_ARBORX_OMP_NUM_THREADS=1
export HPCTOOLKIT_ARBORX_LAUNCH="sh"

# mark configuration for this example
export HPCTOOLKIT_EXAMPLE=ArborX
