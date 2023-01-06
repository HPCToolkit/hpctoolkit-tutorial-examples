#!/bin/bash

$HPCTOOLKIT_LAMMPS_MODULES_BUILD

date > .build_start

rm -rf lammps

mkdir lammps
cd lammps

# Tested for GCC >= 6.4.0, cmake >= 3.3
git clone https://github.com/lammps/lammps.git
cd lammps
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DPKG_KOKKOS=ON -DPKG_NAME=KOKKOS \
      $HPCTOOLKIT_LAMMPS_GPU_ARCH $HPCTOOLKIT_LAMMPS_HOST_ARCH \
      $HPCTOOLKIT_LAMMPS_GPUFLAGS ../cmake
time make -j 4
cd ../../..

touch log.build.done
date > .build_end
