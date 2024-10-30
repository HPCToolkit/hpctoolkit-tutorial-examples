#!/usr/bin/bash -x

GPU=$1

#--------------------------------------------------------
# build kokkos 
#--------------------------------------------------------
mkdir -p kokkos/kokkos-build-$GPU kokkos/kokkos-install-$GPU
pushd kokkos/kokkos-build-$GPU

KOKKOS_INSTALL_DIR=$KOKKOS_SRC/kokkos-install-$GPU

cmake \
    -DKokkos_ENABLE_OPENMP=ON \
    -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
    -DCMAKE_CXX_COMPILER=g++-12 \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_INSTALL_PREFIX=$KOKKOS_INSTALL_DIR \
    ${KOKKOS_CONFIG} \
    ..

make -j 16
make install

# done with kokkos
popd

#--------------------------------------------------------
# build ArborX 
#--------------------------------------------------------
Kokkos_DIR=$KOKKOS_INSTALL_DIR/lib64/cmake
ArborX_DIR=`pwd`/ArborX/arborx-build-$GPU/install/lib/cmake

mkdir -p ArborX/arborx-$GPU
pushd ArborX/arborx-$GPU

cmake \
    -DARBORX_ENABLE_EXAMPLES=true \
    -DCMAKE_INSTALL_PREFIX=`pwd`/../install \
    -DCMAKE_CXX_COMPILER=g++-12 \
    -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g -DNDEBUG -lineinfo" ..
    

# ${ARBORX_CONFIG} ..

make -j 2

popd
