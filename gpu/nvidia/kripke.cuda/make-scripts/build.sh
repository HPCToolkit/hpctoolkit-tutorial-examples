#!/bin/bash

$HPCTOOLKIT_KRIPKE_MODULES_BUILD

date
module list

export KRIPKE_ROOT=`pwd`

echo "Removing previous build of Kripke$QA_TEST_VARIANT"
rm -rf Kripke$QA_TEST_VARIANT

mkdir Kripke$QA_TEST_VARIANT
cd Kripke$QA_TEST_VARIANT
echo ""
echo "====================================================="
echo ""

echo "Building kripke$QA_TEST_VARIANT"

# clone and build kripke
echo "QA_TEST_VARIANT = $QA_TEST_VARIANT"

git clone https://github.com/LLNL/Kripke.git
cd Kripke
git submodule update --init --recursive
export KRIPKE_SRC=`pwd`
echo "build KRIPKE_SRC = $KRIPKE_SRC"

export KRIPKE_INSTALL_DIR=$KRIPKE_SRC/install
echo "KRIPKE_INSTALL_DIR = $KRIPKE_INSTALL_DIR"
export ArborX_DIR=$KRIPKE_INSTALL_DIR/lib/cmake
echo "Kripke_DIR = $Kripke_DIR"
export CMAKE_INSTALL_PREFIX=$KRIPKE_INSTALL_DIR
echo "CMAKE_INSTALL_PREFIX = $CMAKE_INSTALL_PREFIX"
export CMAKE_PREFIX_PATH="$KRIPKE_INSTALL_DIR;$KOKKOS_INSTALL_DIR"
echo "CMAKE_PREFIX_PATH = $CMAKE_PREFIX_PATH"

# if [ "$QA_TEST_VARIANT" = ".cuda" ]; then
#     GPUENABLE="-DKokkos_ENABLE_CUDA=ON"
#     GPUCOMPILER="-DCMAKE_CXX_COMPILER=g++"
# elif [ "$QA_TEST_VARIANT" = ".rocm" ]; then
#     GPUENABLE="-DKokkos_ENABLE_HIP=ON"
#     GPUCOMPILER="-DCMAKE_CXX_COMPILER=hipcc"
# fi

# echo "GPUENABLE = $GPUENABLE"
# echo "GPUCOMPILER = $GPUCOMPILER"
echo ""

# Copy the customized CMakeLists.txt to really enable a cuda build
#  This should be done somehow in configuring....

# save the CMakeLists.txt as it came from the git clone
# cp ./CMakeLists.txt ../../CMakeLists.txt.git
# echo "Copying an old CMakeLists.txt that seems to work"
# cp ../../CMakeLists.txt .

ls -lF
mkdir build
cd build
echo ""

echo "-----------"
echo "Starting cmake of kripke$QA_TEST_VARIANT"
pwd
echo "kripke cmake \
    ${KRIPKE_CONFIG} \
    .. "
echo "-----------"

cmake \
    -C $KRIPKE_ROOT/kripke.cuda.settings \
    ${KRIPKE_CONFIG} \
    ..

echo "Starting make of kripke$QA_TEST_VARIANT"
time make -j 16 > log.make.kripke$QA_TEST_VARIANT 2>&1
makestatus=$?
if [ "$makestatus" != "0" ]; then
    echo "make of kripke$QA_TEST_VARIANT failed"
    echo ""
    echo "Log file (`pwd`/log.make.kripke$QA_TEST_VARIANT) follows :"
    echo ""
    cat `pwd`/log.make.kripke$QA_TEST_VARIANT
    echo "End of Log file"
    echo "Exiting with failure"
    exit $makestatus
else
    echo "make of kripke$QA_TEST_VARIANT succeeded"
fi
echo "End kripke$QA_TEST_VARIANT build"
cd ../../..
pwd
date
