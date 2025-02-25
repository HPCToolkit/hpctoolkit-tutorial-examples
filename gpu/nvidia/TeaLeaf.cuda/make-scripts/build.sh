#!/bin/bash

$HPCTOOLKIT_TEA_MODULES_BUILD

date
module list

if [ -n "$CUDA_PATH" ]; then CUDA_HOME=$CUDA_PATH; fi
if [ -z "$CUDA_HOME" ]
then
  echo "Please export CUDA_HOME to point to an appropriate CUDA Toolkit installation"
  exit 1
fi

echo "Removing previous build of quicksilver$QA_TEST_VARIANT"
rm -rf TeaLeaf_CUDA

echo "Cloning and building TeaLeaf_CUDA"
cp -r ~/examples/cuda/TeaLeaf_CUDA .
cd TeaLeaf_CUDA
export TeaLeaf_SRC=`pwd`
echo "TeaLeaf_SRC = $TeaLeaf_SRC"

time make 

makestatus=$?

if [ "$makestatus" != "0" ]; then
    echo "make of TeaLeaf_CUDA failed"
    exit 1
else
    echo "make of TeaLeaf_CUDA succeeded"
fi
echo "End TeaLeaf_CUDA build"

cd ..
pwd
date
