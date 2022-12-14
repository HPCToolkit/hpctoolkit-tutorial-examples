#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD

date > .build_begin

# Tested for GCC >= 6.4.0, cmake >= 3.3

# PeleC
git clone --recursive https://github.com/AMReX-Combustion/PeleC.git
cd PeleC
mkdir build
cd build
cmake .. -DENABLE_CUDA=ON -DPELEC_ENABLE_CUDA=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo
cd Exec/RegTests/TG
make -j 16
cd ../../../../..

touch log.build.done

date > .build_end

