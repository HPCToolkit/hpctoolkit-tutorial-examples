#!/bin/bash

date > .build_begin

git clone http://github.com/llnl/lulesh
cd lulesh
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_MPI=Off . -DCMAKE_CXX_COMPILER=`which g++`

make -j

date > .build_end
