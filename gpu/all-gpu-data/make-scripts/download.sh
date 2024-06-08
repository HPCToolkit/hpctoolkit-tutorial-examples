#!/bin/bash

rm -rf tarfile 

mkdir tarfile
pushd tarfile
wget http://hpctoolkit.org/sample-data/hpcdata.tgz
popd

tar xf tarfile/hpcdata.tgz
