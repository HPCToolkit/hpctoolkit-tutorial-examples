#!/bin/bash

date > .build_begin

git clone https://github.com/hpcg-benchmark/hpcg src


rm -rf build
mkdir build
pushd build
rm -f ../src/setup/Make.$HPCTOOLKIT_HPCG_CONFIG
cp ../configs/Make.$HPCTOOLKIT_HPCG_CONFIG ../src/setup/Make.$HPCTOOLKIT_HPCG_CONFIG
../src/configure $HPCTOOLKIT_HPCG_CONFIG
make -j 

date > .build_end
