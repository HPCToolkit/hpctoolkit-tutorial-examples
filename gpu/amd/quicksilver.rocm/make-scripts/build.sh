#!/bin/bash

$HPCTOOLKIT_QS_MODULES_BUILD

date
module list

if [ -n "$ROCM_PATH" ]; then ROCM_HOME=$ROCM_PATH; fi
if [ -z "$ROCM_PATH" ]
then
  echo "Please export ROCM_PATH to point to an appropriate ROCm installation"
  exit 1
fi

echo "Removing previous build of quicksilver$QA_TEST_VARIANT"
rm -rf quicksilver$QA_TEST_VARIANT
mkdir quicksilver$QA_TEST_VARIANT
cd quicksilver$QA_TEST_VARIANT

echo "Cloning and building quicksilver"
git clone https://github.com/LLNL/quicksilver
cd quicksilver
export QS_SRC=`pwd`
echo "QS_SRC = $QS_SRC"

if [ -n "$HPCTOOLKIT_QS_MPI_CXX" ]
then
  MPICXXFLAGS="-DHAVE_MPI --compiler-bindir=$(command -v $HPCTOOLKIT_QS_MPI_CXX)"
fi

CXX=mpicxx
CXXFLAGS=-g
CPPFLAGS="-DHAVE_MPI -DHAVE_HIP -x hip --offload-arch=gfx90a -fgpu-rdc -Wno-unused-result"
ROCM_LDFLAGS="-fgpu-rdc --hip-link --offload-arch=gfx90a"


mkdir build
cd build

echo "Starting make -j8 -C ../src CXX=\"${CXX}\" CXXFLAGS=\"${CXXFLAGS}\" ROCM_LDFLAGS=\"${ROCM_LDFLAGS}\" CPPFLAGS=\"${CPPFLAGS}\" LDFLAGS=\"${ROCM_LDFLAGS}\""
time make -j 8  \
  -C ../src  \
  CXX=${CXX} \
  CXXFLAGS="${CXXFLAGS}" \
  ROCM_LDFLAGS="${ROCM_LDFLAGS}" \
  CPPFLAGS="${CPPFLAGS}" \
  LDFLAGS="${ROCM_LDFLAGS}" 2>&1 \
  | tee log.quicksilver$QA_TEST_VARIANT

makestatus=$?

if [ "$makestatus" != "0" ]; then
    echo "make of quicksilver$QA_TEST_VARIANT failed"
    exit 1
else
    echo "make of quicksilver$QA_TEST_VARIANT succeeded"
fi
echo "End quicksilver$QA_TEST_VARIANT build"

cd ../../..
pwd
date
