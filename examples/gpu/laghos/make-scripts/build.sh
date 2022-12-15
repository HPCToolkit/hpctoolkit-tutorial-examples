#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD

date > .build_begin

mkdir laghos
pushd laghos

# Tested for GCC >= 6.4.0

# CUDA Laghos
git clone https://github.com/CEED/Laghos.git
pushd Laghos
git checkout v3.1
git apply ../../make-scripts/tutorial.patch
make setup NPROC=16 MFEM_BUILD="pcuda CUDA_ARCH=sm_$HPCTOOLKIT_CUDA_ARCH BASE_FLAGS='-std=c++11 -g'"
make -j 8
popd
popd

touch log.build.done

date > .build_end
