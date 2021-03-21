#!/bin/bash

export CMAKE_MAJOR_VERSION=`cmake --version | head -1 | tr '.' ' ' | awk '{print $3}'`
export CMAKE_MINOR_VERSION=`cmake --version | head -1 | tr '.' ' ' | awk '{print $4}'`

echo using cmake $CMAKE_MAJOR_VERSION.$CMAKE_MINOR_VERSION

if (( $CMAKE_MAJOR_VERSION < 3 )) 
then
 echo a cmake version 3.3 or greater must be on your path
 exit
else
   if (( $CMAKE_MAJOR_VERSION == 3 )) 
   then 
      if (( $CMAKE_MINOR_VERSION < 3 ))
      then
         echo a cmake version 3.3 or greater must be on your path
         exit
      fi
    fi
fi


export GCC_MAJOR_VERSION=`gcc --version | head -1 | tr '.' ' ' | awk '{print $3}'`
export GCC_MINOR_VERSION=`gcc --version | head -1 | tr '.' ' ' | awk '{print $4}'`

echo using gcc $GCC_MAJOR_VERSION.$GCC_MINOR_VERSION

if (( $GCC_MAJOR_VERSION < 6 )) 
then
 echo a gcc version 6.4 or greater must be on your path
 exit
else
   if (( $GCC_MAJOR_VERSION == 6 )) 
   then 
      if (( $GCC_MINOR_VERSION < 4 ))
      then
         echo a gcc version 6.4 or greater must be on your path
         exit
      fi
    fi
fi

echo using gcc version $GCC_MAJOR_VERSION.$GCC_MINOR_VERSION


mkdir build
cd build

# Tested for GCC >= 6.4.0, cmake >= 3.3
git clone https://github.com/lammps/lammps.git
cd lammps
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DPKG_KOKKOS=ON -DPKG_NAME=KOKKOS -DKokkos_ARCH_VOLTA70=ON -DKokkos_ARCH_HOSTARCH=POWER9 -DKokkos_ARCH_GPUARCH=VOLTA70 -DKokkos_ENABLE_CUDA=yes -DKokkos_ENABLE_OPENMP=yes -DCMAKE_CXX_COMPILER=`pwd`/../lib/kokkos/bin/nvcc_wrapper ../cmake
make -j16
cd ../..
