#!/bin/bash

$HPCTOOLKIT_QS_MODULES_BUILD

date
# module list

if [ -n "$CUDA_PATH" ]; then CUDA_HOME=$CUDA_PATH; fi
if [ -z "$CUDA_HOME" ]
then
  echo "Please export CUDA_HOME to point to an appropriate CUDA Toolkit installation"
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

OPTFLAGS="-O2 -lineinfo -g"
#version below for more accurate gpu source info, but no optimization
#OPTFLAGS = -g -G -O0

CUDAFLAGS="-gencode=arch=compute_${HPCTOOLKIT_CUDA_ARCH},code=\\\"sm_${HPCTOOLKIT_CUDA_ARCH},compute_${HPCTOOLKIT_CUDA_ARCH}\\\""
CPPFLAGS="-x cu -dc"
CUDA_LDFLAGS="-L${CUDA_HOME}/lib64 -lcuda"

CXX="${CUDA_HOME}/bin/nvcc"

if [ -n "$HPCTOOLKIT_QS_MPI_CXX" ]
then
  MPICXXFLAGS="-DHAVE_MPI --compiler-bindir=$(command -v $HPCTOOLKIT_QS_MPI_CXX)"
fi

CXXFLAGS="${MPICXXFLAGS} -DHAVE_CUDA -std=c++11 ${OPTFLAGS} ${CUDAFLAGS}"

mkdir build
cd build

echo "Starting make -j8 -C ../src CXX=\"${CXX}\" CXXFLAGS=\"${CXXFLAGS}\" CUDA_LDFLAGS=\"${CUDA_LDFLAGS}\" CPPFLAGS=\"${CPPFLAGS}\" LDFLAGS=\"${CUDA_LDFLAGS}\""
time make -j 8  \
  -C ../src  \
  CXX=${CXX} \
  CXXFLAGS="${CXXFLAGS}" \
  CUDA_LDFLAGS="${CUDA_LDFLAGS}" \
  CPPFLAGS="${CPPFLAGS}" \
  LDFLAGS="${CUDA_LDFLAGS}" 2>&1 \
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
