#!/bin/bash

$HPCTOOLKIT_ARBORX_MODULES_BUILD

date > .build_start
rm -rf ArborX$QA_TEST_VARIANT

mkdir ArborX$QA_TEST_VARIANT
cd ArborX$QA_TEST_VARIANT
echo ""
echo "====================================================="
echo ""

# First clone and build kokkos
git clone https://github.com/kokkos/kokkos
cd kokkos
export KOKKOS_SRC=`pwd`
mkdir kokkos-build kokkos-install
cd kokkos-build
export KOKKOS_INSTALL_DIR=$KOKKOS_SRC/kokkos-install

echo "Starting cmake kokkos$SQA_TEST_VARIANT"
pwd

echo "KOKKOS_SRC = $KOKKOS_SRC"
echo "KOKKOS_INSTALL_DIR = $KOKKOS_INSTALL_DIR"
echo ""
echo "KOKKOS_CONFIG = $KOKKOS_CONFIG"
echo "kokkos cmake \
    -DKokkos_ENABLE_OPENMP=OFF \
    -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_INSTALL_PREFIX=$KOKKOS_INSTALL_DIR \
    ${KOKKOS_CONFIG} \
    ..  "

echo "-----------"
cmake \
    -DKokkos_ENABLE_OPENMP=OFF \
    -DCMAKE_BUILD_TYPE=RelWithDebugInfo \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_INSTALL_PREFIX=$KOKKOS_INSTALL_DIR \
    ${KOKKOS_CONFIG} \
    ..  

echo "Starting make install of kokkos$QA_TEST_VARIANT"
time make install -j16 > log.kokkos$QA_TEST_VARIANT 2>&1
makestatus=$?

if [ "$makestatus" != "0" ]; then
    echo "make of kokkos$QA_TEST_VARIANT failed"
    exit 1
else
    echo "make of kokkos$QA_TEST_VARIANT succeeded"
fi
echo "End kokkos$QA_TEST_VARIANT build"

# done with kokkos

cd ../..
echo ""
echo "====================================================="
echo ""
pwd
echo "Done with kokkos build; building arborx"

# clone and build arborx
echo "QA_TEST_VARIANT = $QA_TEST_VARIANT"

git clone https://github.com/arborx/ArborX
cd ArborX
export ARBORX_SRC=`pwd`
echo "build ARBORX_SRC = $ARBORX_SRC"

export ARBORX_INSTALL_DIR=$ARBORX_SRC/install
echo "ARBORX_INSTALL_DIR = $ARBORX_INSTALL_DIR"
export ArborX_DIR=$ARBORX_INSTALL_DIR/lib/cmake
echo "ArborX_DIR = $ArborX_DIR"
export Kokkos_DIR=$KOKKOS_INSTALL_DIR/lib64/cmake
echo "Kokkos_DIR = $Kokkos_DIR"
export CMAKE_INSTALL_PREFIX=$ARBORX_INSTALL_DIR
echo "CMAKE_INSTALL_PREFIX = $CMAKE_INSTALL_PREFIX"
export CMAKE_PREFIX_PATH="$ARBORX_INSTALL_DIR;$KOKKOS_INSTALL_DIR"
echo "CMAKE_PREFIX_PATH = $CMAKE_PREFIX_PATH"

if [ "$QA_TEST_VARIANT" = ".cuda" ]; then
    GPUENABLE="-DKokkos_ENABLE_CUDA=ON"
    GPUCOMPILER="-DCMAKE_CXX_COMPILER=g++"
elif [ "$QA_TEST_VARIANT" = ".rocm" ]; then
    GPUENABLE="-DKokkos_ENABLE_HIP=ON"
    GPUCOMPILER="-DCMAKE_CXX_COMPILER=hipcc"
fi

echo "GPUENABLE = $GPUENABLE"
echo "GPUCOMPILER = $GPUCOMPILER"
echo "KOKKOS_SRC = $KOKKOS_SRC"
echo "KOKKOS_INSTALL_DIR = $KOKKOS_INSTALL_DIR"
echo "ARBORX_CONFIG = $ARBORX_CONFIG"
echo ""

mkdir install
mkdir build
cd build
# echo "contents of current directory (`pwd`):"
# ls -al
# echo ""
# echo "contents of parent directory (`pwd`/..):"
# ls -al ..
# echo ""
echo "contents of build directory (`pwd`):"
ls -al
echo ""
echo "contents of build's parent directory (`pwd`/..):"
ls -al ..
echo ""

echo "-----------"
echo "Starting cmake of arborx"
pwd
echo "arborx cmake \
    -DARBORX_ENABLE_EXAMPLES=true \
    -DCMAKE_PREFIX_PATH=$KOKKOS_INSTALL_DIR;$ARBORX_INSTALL_DIR \
    -DCMAKE_INSTALL_PREFIX=$ARBORX_INSTALL_DIR \
    ${ARBORX_CONFIG} \
    .. "
echo "-----------"

cmake \
    -DARBORX_ENABLE_EXAMPLES=true \
    -DCMAKE_PREFIX_PATH=$KOKKOS_INSTALL_DIR;$ARBORX_INSTALL_DIR \
    -DCMAKE_INSTALL_PREFIX=$ARBORX_INSTALL_DIR \
    ${ARBORX_CONFIG} \
    ..

echo "Starting make of arborx"
time make -j 16 > log.arborx$QA_TEST_VARIANT 2>&1
makestatus=$?
if [ "$makestatus" != "0" ]; then
    echo "make of arborx$QA_TEST_VARIANT failed"
else
    echo "make of arborx$QA_TEST_VARIANT succeeded"
fi
echo "End arborx$QA_TEST_VARIANT build"
cd ../../..
pwd
touch build-done
date > .build_end
