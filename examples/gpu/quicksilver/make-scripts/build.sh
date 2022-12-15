#!/bin/bash

date > .build_begin

$HPCTOOLKIT_QS_MODULES_BUILD

if [ -n "$CUDA_PATH" ]; then CUDA_HOME=$CUDA_PATH; fi
if [ -z "$CUDA_HOME" ]
then
  echo "Please export CUDA_HOME to point to an appropriate CUDA Toolkit installation"
  exit 1
fi

rm -rf quicksilver

# Quicksilver
git clone https://github.com/LLNL/quicksilver

OPTFLAGS="-O2 -lineinfo -g"
#version below for more accurate gpu source info, but no optimization
#OPTFLAGS = -g -G -O0

CUDAFLAGS="-gencode=arch=compute_${HPCTOOLKIT_CUDA_ARCH},code=\\\"sm_${HPCTOOLKIT_CUDA_ARCH},compute_${HPCTOOLKIT_CUDA_ARCH}\\\""
CPPFLAGS="-x cu -dc"
CUDA_LDFLAGS="-L${CUDA_HOME}/lib64 -lcuda -lcudart"

CXX="${CUDA_HOME}/bin/nvcc"
if [ -n "$HPCTOOLKIT_MPI_CXX" ]
then
  MPICXXFLAGS="-DHAVE_MPI --compiler-bindir=$(command -v $HPCTOOLKIT_MPI_CXX)"
fi

CXXFLAGS="${MPICXXFLAGS} -DHAVE_CUDA -std=c++11 ${OPTFLAGS} ${CUDAFLAGS}"

echo make -j -C quicksilver/src CXX="${CXX}" CXXFLAGS="${CXXFLAGS}" CUDA_LDFLAGS="${CUDA_LDFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${CUDA_LDFLAGS}"
make -j -C quicksilver/src CXX="${CXX}" CXXFLAGS="${CXXFLAGS}" CUDA_LDFLAGS="${CUDA_LDFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${CUDA_LDFLAGS}"

touch log.build.done
date > .build_end
