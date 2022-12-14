#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD

date > .build_begin

mkdir laghos
pushd laghos

# Tested for GCC >= 6.4.0, cmake >= 3.3

# CUDA Laghos
git clone https://github.com/Jokeren/Laghos.git
pushd Laghos
git checkout tutorial
make setup NPROC=16 MFEM_BUILD="pcuda CUDA_ARCH=$HPCTOOLKIT_CUDA_ARCH BASE_FLAGS='-std=c++11 -g'"
make -j 8
popd
popd

touch log.build.done

date > .build_end
