#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD

date > .build_begin

# Tested for GCC >= 6.4.0, cmake >= 3.3

# PeleC
git clone --recursive https://github.com/AMReX-Combustion/PeleC.git
mkdir -p PeleC/build
pushd PeleC/build
cmake .. -DENABLE_${HPCTOOLKIT_PELEC_GPU_PLATFORM^^}=ON -DPELEC_ENABLE_${HPCTOOLKIT_PELEC_GPU_PLATFORM^^}=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo
cd Exec/RegTests/PMF
make TPL
make -j 16
popd

touch log.build.done

date > .build_end

