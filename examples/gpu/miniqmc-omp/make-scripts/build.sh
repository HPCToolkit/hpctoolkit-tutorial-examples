#!/bin/bash

date > .build_begin

$HPCTOOLKIT_MINIQMC_MODULES_BUILD

rm -rf miniqmc

if [[ -z "$CUDA_HOME" ]]; then
  if [[ ! -z "$CUDA_PATH" ]]; then
    export CUDA_HOME=$CUDA_PATH
  elif [[ ! -z "$NVHPC_CUDA_PATH" ]]; then
    export CUDA_HOME=$NVHPC_CUDA_PATH
  fi
fi
echo using CUDA_HOME=$CUDA_HOME

if [[ -z "$MPI_HOME" ]]; then
  if [[ ! -z "$MPI_ROOT" ]]; then
    export MPI_HOME=$MPI_ROOT
  elif [[ ! -z "$CRAY_MPICH_DIR" ]]; then
    export MPI_HOME=$CRAY_MPICH_DIR
  fi
fi
echo using MPI_HOME=$MPI_HOME

if [[ -z "`type -p cmake`" ]] 
then
  echo "CMake version 3.21 or newer was not found in your PATH"
  exit
fi

export CMAKE_MAJOR_VERSION=`cmake --version | head -1 | tr '.' ' ' | awk '{print $3}'`
export CMAKE_MINOR_VERSION=`cmake --version | head -1 | tr '.' ' ' | awk '{print $4}'`

echo using cmake $CMAKE_MAJOR_VERSION.$CMAKE_MINOR_VERSION

if (( $CMAKE_MAJOR_VERSION < 3 )) 
then
 echo "CMake version 3.21 or newer was not found in your PATH"
 exit
else
   if (( $CMAKE_MAJOR_VERSION == 3 )) 
   then 
      if (( $CMAKE_MINOR_VERSION < 21 ))
      then
         echo "CMake version 3.21 or newer was not found in your PATH"
         exit
      fi
    fi
fi


# miniqmc
git clone https://github.com/QMCPACK/miniqmc.git
pushd miniqmc
git checkout OMP_offload
popd
mkdir miniqmc/miniqmc-build
pushd miniqmc/miniqmc-build
cmake -DCMAKE_CXX_COMPILER=$HPCTOOLKIT_MINIQMC_CXX_COMPILER -DCMAKE_BUILD_TYPE=RelWithDebInfo $HPCTOOLKIT_MINIQMC_GPUFLAGS ..
make -j VERBOSE=1
popd

date > .build_end
