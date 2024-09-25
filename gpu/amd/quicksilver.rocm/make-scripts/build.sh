#!/bin/bash

$HPCTOOLKIT_QS_MODULES_BUILD

date
module list

if [ -n "$ROCM_PATH" ]; then ROCM_HOME=$ROCM_PATH; fi
if [ -z "$ROCM_PATH" ]
then
  echo "Please export ROCM_PATH to point to an appropriate ROCm installation"
  exit 1
fi

echo "Removing previous build of quicksilver$QA_TEST_VARIANT"
rm -rf quicksilver$QA_TEST_VARIANT
mkdir quicksilver$QA_TEST_VARIANT
cd quicksilver$QA_TEST_VARIANT

echo "Cloning and building quicksilver"
git clone https://github.com/LLNL/quicksilver
cd quicksilver
export QS_SRC=`pwd`
echo "QS_SRC = $QS_SRC"

mkdir build
cd build

echo Starting make -j 8  \
  -C ../src  \
  CXX=${HPCTOOLKIT_QS_CXX} \
  CXXFLAGS="${HPCTOOLKIT_QS_CXXFLAGS}" \
  ROCM_LDFLAGS="${HPCTOOLKIT_QS_ROCM_LDFLAGS}" \
  CPPFLAGS="${HPCTOOLKIT_QS_CPPFLAGS}" \
  LDFLAGS="${HPCTOOLKIT_QS_ROCM_LDFLAGS}" 2>&1 \
  | tee log.quicksilver$QA_TEST_VARIANT

time make -j 8  \
  -C ../src  \
  CXX=${HPCTOOLKIT_QS_CXX} \
  CXXFLAGS="${HPCTOOLKIT_QS_CXXFLAGS}" \
  ROCM_LDFLAGS="${HPCTOOLKIT_QS_ROCM_LDFLAGS}" \
  CPPFLAGS="${HPCTOOLKIT_QS_CPPFLAGS}" \
  LDFLAGS="${HPCTOOLKIT_QS_ROCM_LDFLAGS}" 2>&1 \
  | tee log.quicksilver$QA_TEST_VARIANT

makestatus=$?

if [ "$makestatus" != "0" ]; then
    echo "make of quicksilver$QA_TEST_VARIANT failed"
    exit 1
else
    echo "make of quicksilver$QA_TEST_VARIANT succeeded"
fi
echo "End quicksilver$QA_TEST_VARIANT build"

cd ../../..
pwd
date
