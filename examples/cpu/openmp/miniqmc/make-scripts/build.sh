#!/bin/bash

date > .build_begin


if [[ ! -z "$MPI_ROOT" ]] 
then
    export MPI_HOME=$MPI_ROOT
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


# miniqmc
git clone https://github.com/QMCPACK/miniqmc.git
mkdir miniqmc/miniqmc-build
pushd miniqmc/miniqmc-build
# cmake -DCMAKE_CXX_COMPILER=mpicxx -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_LDFLAGS=-lessl ..
cmake -DCMAKE_CXX_COMPILER=mpicxx -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
make -j

date > .build_end
