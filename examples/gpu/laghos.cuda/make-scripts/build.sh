#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD

date
module list

echo "Removing previous build of laghos$QA_TEST_VARIANT"
rm -rf laghos$QA_TEST_VARIANT

mkdir laghos$QA_TEST_VARIANT
pushd laghos$QA_TEST_VARIANT

echo "Cloning Laghos"
git clone https://github.com/CEED/Laghos.git
pushd Laghos

echo "Checking out tutorial version"
git checkout tutorial

echo "Running make config for laghos$QA_TEST_VARIANT"

make setup NPROC=16 MFEM_BUILD="pcuda CUDA_ARCH=$HPCTOOLKIT_CUDA_ARCH BASE_FLAGS='-std=c++11 -g'"
echo "Running make for laghos$QA_TEST_VARIANT"
make -j 8
popd
popd

pwd
date
