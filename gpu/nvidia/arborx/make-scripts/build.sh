#!/usr/bin/bash -x

# remove any prior copies that might exist
rm -rf kokkos ArborX

git clone https://github.com/kokkos/kokkos
git clone https://github.com/arborx/ArborX

export CRAYPE_LINK_TYPE=dynamic

export KOKKOS_SRC=`pwd`/kokkos

CMAKE_COMMON_OPTIONS="\
    -DKokkos_ENABLE_OPENMP=ON \
    -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
    -DCMAKE_CXX_STANDARD=17"

KOKKOS_CONFIG_CUDA="\
    -DCUDAToolkit_BIN_DIR=/opt/nvidia/hpc_sdk/Linux_x86_64/23.9/cuda/12.2/bin \
    -DCUDAToolkit_NVCC_EXECUTABLE=/opt/nvidia/hpc_sdk/Linux_x86_64/23.9/compilers/bin/nvcc \
    -DCMAKE_CXX_COMPILER=g++-12 \
    -DKokkos_ENABLE_CUDA=ON \
    -DKokkos_ARCH_AMPERE80=ON"

ARBORX_CONFIG_CUDA="\
	-DCMAKE_CXX_COMPILER=g++-12 \
	-DCMAKE_CXX_FLAGS_RELWITHDEBINFO=\\\"-O2 -g -DNDEBUG -lineinfo\\\" "


export KOKKOS_CONFIG=${KOKKOS_CONFIG_CUDA}
export ARBORX_CONFIG=${ARBORX_CONFIG_CUDA}

make-scripts/build-gpu.sh cuda

echo > build-done
