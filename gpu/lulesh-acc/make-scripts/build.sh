#!/bin/bash

date > .build_begin

$HPCTOOLKIT_LULESH_ACC_MODULES_BUILD

rm -rf LULESH tarfile

mkdir tarfile
pushd tarfile
wget http://hpctoolkit.org/sample-codes/lulesh-acc.tgz
popd

tar xf tarfile/lulesh-acc.tgz
pushd LULESH/openacc/src
make CXX="$HPCTOOLKIT_LULESH_ACC_CXX" CXXFLAGS="$HPCTOOLKIT_LULESH_ACC_CXXFLAGS" ACCFLAGS="$HPCTOOLKIT_LULESH_ACC_ACCFLAGS"
popd

touch log.build.done
date > .build_end
