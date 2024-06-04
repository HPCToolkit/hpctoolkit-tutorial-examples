#!/bin/bash

$HPCTOOLKIT_LAMMPS_MODULES_BUILD

date
module list

rm -rf lammps$QA_TEST_VARIANT

mkdir lammps$QA_TEST_VARIANT && cd lammps$QA_TEST_VARIANT

# Tested for GCC >= 6.4.0, cmake >= 3.3
git clone https://github.com/lammps/lammps.git
cd lammps
mkdir build && cd build
eval cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DPKG_KOKKOS=ON \
      $HPCTOOLKIT_LAMMPS_GPU_ARCH $HPCTOOLKIT_LAMMPS_HOST_ARCH \
      -DKokkos_ENABLE_ROCTHRUST=OFF \
      $HPCTOOLKIT_LAMMPS_GPUFLAGS ../cmake
time make -j 8
cd ../../..
pwd
date
