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
