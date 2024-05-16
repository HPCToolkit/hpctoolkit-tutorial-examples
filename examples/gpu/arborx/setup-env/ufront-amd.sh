# load modules needed to build and run arborx
module use /projects/modulefiles
module use /usr/local/modules
# module load cuda/11.8
# module load cmake

export QA_TEST_VARIANT=".rocm"

CMAKE_COMMON_OPTIONS="\
    -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
    -DCMAKE_CXX_STANDARD=17 "

KOKKOS_CONFIG_ROCM="\
    $CMAKE_COMMON_OPTIONS \
    -DCMAKE_CXX_COMPILER=hipcc \
    -DKokkos_ENABLE_HIP=ON \
    -DKokkos_ENABLE_ROCTHRUST=OFF \
    -DKokkos_ARCH_AMD_GFX90A=ON "

export KOKKOS_CONFIG=$KOKKOS_CONFIG_ROCM

ARBORX_CONFIG_ROCM="\
    $CMAKE_COMMON_OPTIONS \
    -DKokkos_ENABLE_HIP=ON \
    -DCMAKE_CXX_COMPILER=hipcc "

export ARBORX_CONFIG=$ARBORX_CONFIG_ROCM

export OMP_PROC_BIND=spread
export OMP_PLACES=threads


# modules for hpctoolkit
export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/2024.01.stable/cuda11.8.0-rocm5.7.1"
$HPCTOOLKIT_MODULES_HPCTOOLKIT

# environment settings for this example
export HPCTOOLKIT_GPU_PLATFORM=amd
export HPCTOOLKIT_ARBORX_ROOT="$(pwd)"
export HPCTOOLKIT_ARBORX_MODULES_BUILD=""
export HPCTOOLKIT_ARBORX_GPU_ARCH="-DKokkos_ARCH_VEGA90A=ON"
# export HPCTOOLKIT_ARBORX_HOST_ARCH="-DKokkos_ARCH_ZEN1=ON"
# export HPCTOOLKIT_ARBORX_GPUFLAGS="-DKokkos_ENABLE_HIP=yes -DCMAKE_CXX_COMPILER=$(which hipcc) -DCMAKE_CXX_FLAGS=\"-g\""
export HPCTOOLKIT_ARBORX_SUBMIT="sh"
export HPCTOOLKIT_ARBORX_RUN="sh"
export HPCTOOLKIT_ARBORX_RUN_PC="sh"
export HPCTOOLKIT_ARBORX_BUILD="sh"
export HPCTOOLKIT_ARBORX_OMP_NUM_THREADS=1
export HPCTOOLKIT_ARBORX_LAUNCH="sh"

# mark configuration for this example
export HPCTOOLKIT_EXAMPLE=ArborX
