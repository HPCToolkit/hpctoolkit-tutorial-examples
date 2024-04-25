#!/bin/bash
git clone https://github.com/arborx/ArborX

#build ArborX
pushd ArborX
cmake  -DARBORX_ENABLE_EXAMPLES=true \
	-DCMAKE_INSTALL_PREFIX=`pwd`/../install \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g -DNDEBUG -lineinfo"

make -j 16 
echo > build-done
