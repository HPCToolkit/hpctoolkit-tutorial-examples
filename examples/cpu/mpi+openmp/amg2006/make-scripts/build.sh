#!/bin/bash

STD_CFLAGS=" -DTIMER_USE_MPI -DHYPRE_USING_OPENMP -DHYPRE_NO_GLOBAL_PARTITION -DHYPRE_LONG_LONG"
OMP_CFLAGS=" -O2 -g -fopenmp "
STD_LDFLAGS=" -dynamic -fopenmp -lm"

date > .build_begin

if [[ -z "$MPI_CC" ]] 
then
    echo MPI_CC must be set
    exit
fi


if [[ -z "`type -p cmake`" ]] 
then
    echo cmake version 3.3 or newer was not found in your PATH 
    exit
fi

echo using MPI_HOME=$MPI_HOME

# AMG2006

# download tar file
mkdir tarfile
pushd tarfile
wget https://asc.llnl.gov/sequoia/benchmarks/AMG2006_v1.0.tar.gz
popd

# unpack tar file
tar xzf tarfile/AMG2006_v1.0.tar.gz

# build application
make -j -C AMG2006 CC=${MPI_CC} INCLUDE_CFLAGS="${OMP_CFLAGS} ${STD_CFLAGS}" INCLUDE_LFLAGS="${STD_LDFLAGS}"

date > .build_end
