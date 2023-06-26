#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD

date > .build_begin

mkdir laghos
pushd laghos

# Tested for GCC >= 6.4.0

# RAJA
if [ -n "${HPCTOOLKIT_LAGHOS_RAJA_BUILD}" ]; then
  RAJA_BLD=${HPCTOOLKIT_LAGHOS_RAJA_ROOT}/build
  RAJA_PFX=$(pwd)/raja
  git clone -b ${HPCTOOLKIT_LAGHOS_RAJA_VER} --depth 1 --recurse-submodules --shallow-submodules https://github.com/LLNL/RAJA.git ${HPCTOOLKIT_LAGHOS_RAJA_ROOT}
  mkdir -p ${RAJA_BLD}
  pushd ${RAJA_BLD}
    cmake \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${RAJA_PFX} \
      -DCMAKE_CXX_COMPILER=${HPCTOOLKIT_LAGHOS_CXX_COMPILER} -DCMAKE_CXX_FLAGS="${HPCTOOLKIT_LAGHOS_CXXFLAGS}" \
      ${HPCTOOLKIT_LAGHOS_RAJA_FLAGS} \
      ${HPCTOOLKIT_LAGHOS_RAJA_ROOT}
    make -j 8
    make install
  popd
fi

# Laghos
git clone https://github.com/CEED/Laghos.git
pushd Laghos
git checkout v3.1
git apply ../../make-scripts/tutorial.patch
make setup NPROC=16 CXXFLAGS="-g -O2 ${HPCTOOLKIT_LAGHOS_CXXFLAGS}" MFEM_BUILD="${HPCTOOLKIT_LAGHOS_MFEM_FLAGS}"
make -j 8
popd
popd

touch log.build.done

date > .build_end
