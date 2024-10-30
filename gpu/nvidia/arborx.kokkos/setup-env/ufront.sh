
export HPCTOOLKIT_EXAMPLE=ArborX
#kokkos settings
export Kokkos_DIR=`pwd`/kokkos/kokkos-install/lib64/cmake

#ArborX settings
export ArborX_DIR=`pwd`/ArborX/work/prgenv-gnu/install/lib/cmake
export ArborX_DIR=`pwd`/ArborX/work/prgenv-gnu/install/lib/cmake
export OMP_PROC_BIND=spread
export OMP_PLACES=threads

#hpctoolkit
module use /projects/modulefiles
module load hpctoolkit
export HPCTOOLKIT_HPCSTRUCT_CACHE=`pwd`/hpcstruct-cache
