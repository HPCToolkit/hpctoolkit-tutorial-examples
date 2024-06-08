#!/bin/bash

date > .build_begin

$HPCTOOLKIT_LULESH_OMP_MODULES_BUILD

rm -rf LULESH tarfile

mkdir tarfile
pushd tarfile
wget http://hpctoolkit.org/sample-codes/lulesh-omp.tgz
popd

# git clone https://github.com/LLNL/LULESH.git
# pushd LULESH
# git checkout 2.0.2-dev
# pushd omp_4.0

tar xf tarfile/lulesh-omp.tgz
pushd LULESH/omp_4.0
echo make CXX="$HPCTOOLKIT_LULESH_OMP_CXX" CXXFLAGS="$HPCTOOLKIT_LULESH_OMP_CXXFLAGS" OMPFLAGS="$HPCTOOLKIT_LULESH_OMP_OMPFLAGS"
make CXX="$HPCTOOLKIT_LULESH_OMP_CXX" CXXFLAGS="$HPCTOOLKIT_LULESH_OMP_CXXFLAGS" OMPFLAGS="$HPCTOOLKIT_LULESH_OMP_OMPFLAGS"
popd

touch log.build.done
date > .build_end
