#!/bin/bash

date > .build_begin

if [[ ! -z "$CUDAPATH" ]] 
then
    export CUDA_HOME=$CUDAPATH
fi


if [[ ! -z "$MPI_ROOT" ]] 
then
    export MPI_HOME=$MPI_ROOT
fi

if [[ -z "$CUDA_HOME" ]] 
then
    echo CUDA_HOME must be set
    exit
fi

if [[ -z "$MPI_HOME" ]] 
then
    echo MPI_HOME must be set
    exit
fi


if [[ -z "`type -p cmake`" ]] 
then
    echo cmake version 3.3 or newer was not found in your PATH 
    exit
fi

echo using CUDA_HOME=$CUDA_HOME
echo using MPI_HOME=$MPI_HOME

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


# Tested for GCC >= 6.4.0, cmake >= 3.3

# Quicksilver
git clone https://github.com/LLNL/quicksilver
make build-quicksilver 

date > .build_end
