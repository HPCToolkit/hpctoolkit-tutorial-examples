#!/bin/bash

rm -rf tarfile hpctoolkit-miniqmc-gpu-openmp.d

mkdir tarfile
pushd tarfile
wget http://hpctoolkit.org/sample-data/miniqmc.tgz
popd

tar xf tarfile/miniqmc.tgz
