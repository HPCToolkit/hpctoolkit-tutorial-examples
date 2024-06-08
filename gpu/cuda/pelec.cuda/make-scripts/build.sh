#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD

date

# Tested for GCC >= 6.4.0, cmake >= 3.3
/bin/rm -rf PeleC${QA_TEST_VARIANT}

# PeleC
git clone --recursive https://github.com/AMReX-Combustion/PeleC.git PeleC${QA_TEST_VARIANT}
cd PeleC${QA_TEST_VARIANT}
git apply ../make-scripts/tutorial.patch
mkdir -p build
pushd build
cmake -DCMAKE_CXX_COMPILER=$HPCTOOLKIT_PELEC_CXX_COMPILER -DCMAKE_BUILD_TYPE=RelWithDebInfo $HPCTOOLKIT_PELEC_GPUFLAGS ..
cd Exec/RegTests/TG
make -j 16
popd

pwd
date

