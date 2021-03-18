#!/bin/bash

date > .build_begin

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
pushd build

# Tested for GCC >= 6.4.0, cmake >= 3.3

# CUDA Laghos
git clone https://github.com/Jokeren/Laghos.git
pushd Laghos
git checkout tutorial
make setup MFEM_BUILD="pcuda -j 8 CUDA_ARCH='sm_70 -lineinfo' BASE_FLAGS='-std=c++11 -g'"
make -j 8
popd
popd

date > .build_end
