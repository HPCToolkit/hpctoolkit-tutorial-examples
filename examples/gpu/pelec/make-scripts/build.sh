#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD

date > .build_begin

# Tested for GCC >= 6.4.0, cmake >= 3.3

# PeleC
git clone --recursive https://github.com/AMReX-Combustion/PeleC.git
mkdir -p PeleC/build
pushd PeleC/build
cmake -DCMAKE_CXX_COMPILER=$HPCTOOLKIT_PELEC_CXX_COMPILER -DCMAKE_BUILD_TYPE=RelWithDebInfo $HPCTOOLKIT_PELEC_GPUFLAGS ..
cd Exec/RegTests/TG
make -j 16
popd

touch log.build.done

date > .build_end

