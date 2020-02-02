#!/bin/bash

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


mkdir build
cd build

# Tested for GCC >= 6.4.0, cmake >= 3.3

# hypre
wget https://github.com/LLNL/hypre/archive/v2.11.2.tar.gz
tar -xvf v2.11.2.tar.gz
cd hypre-2.11.2/src
./configure --disable-fortran --with-MPI --with-MPI-include=$MPI_HOME/include --with-MPI-lib-dirs=$MPI_HOME/lib
make -j8
cd ../..

# metis
wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz
tar xzvf metis-5.1.0.tar.gz
cd metis-5.1.0
make config prefix=`pwd`
make -j8 && make install
cd ..

# mfem
git clone https://github.com/mfem/mfem.git
cd mfem
git checkout laghos-v2.0
make config MFEM_DEBUG=YES MFEM_USE_MPI=YES HYPRE_DIR=`pwd`/../hypre-2.11.2/src/hypre MFEM_USE_METIS_5=YES METIS_DIR=`pwd`/../metis-5.1.0
make status
make -j8
cd ..

# raja
# git clone --recursive https://github.com/llnl/raja.git
# cd raja
# git checkout v0.5.0
# git submodule init && git submodule update
# rm -rf build
# mkdir build && cd build
# cmake -DENABLE_CUDA=TRUE -DCMAKE_CUDA_COMPILER=nvcc -DCUDA_ARCH=sm_70 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=../../raja-install ..
# make install -j8
# cd ../..

# CUDA Laghos
git clone https://github.com/Jokeren/Laghos.git
cd Laghos/cuda
make debug NV_ARCH=-arch=sm_70 CUDA_DIR=$CUDA_HOME MPI_HOME=$MPI_HOME -j8
cd ../..
