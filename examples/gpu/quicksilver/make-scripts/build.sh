#!/bin/bash

date > .build_begin

$HPCTOOLKIT_QS_MODULES_BUILD

rm -rf quicksilver 

# Quicksilver
git clone https://github.com/LLNL/quicksilver

OPTFLAGS="-O2 -lineinfo -g"
#version below for more accurate gpu source info, but no optimization
#OPTFLAGS = -g -G -O0

CXX="${CUDA_HOME}/bin/nvcc"
CXXFLAGS="-DHAVE_CUDA -std=c++11 ${OPTFLAGS} -gencode=arch=compute_70,code=\\\"sm_70,compute_70\\\""
CPPFLAGS="-x cu -dc"

LDFLAGS="-L${CUDA_HOME}/lib64 -lcuda -lcudart"

echo make -j -C quicksilver/src CXX="${CXX}" CXXFLAGS="${CXXFLAGS}" CUDA_LDFLAGS="${CUDA_LDFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${CUDA_LDFLAGS}"
make -j -C quicksilver/src CXX="${CXX}" CXXFLAGS="${CXXFLAGS}" CUDA_LDFLAGS="${CUDA_LDFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${CUDA_LDFLAGS}"

touch log.build.done
date > .build_end
