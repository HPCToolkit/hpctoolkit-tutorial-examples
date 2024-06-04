
export HPCTOOLKIT_EXAMPLE=ArborX
#kokkos settings
module use /global/common/software/nersc/pe/modulefiles/latest
module load kokkos-gpu/4.3.00
export Kokkos_DIR=/global/common/software/nersc9/kokkos/4.3.00/gpu/lib64/cmake

#ArborX settings
export ArborX_DIR=`pwd`/ArborX/work/prgenv-gnu/install/lib/cmake
export ArborX_DIR=`pwd`/ArborX/work/prgenv-gnu/install/lib/cmake
export OMP_PROC_BIND=spread
export OMP_PLACES=threads

#hpctoolkit
module use /global/cfs/cdirs/m3977/modulefiles
module load hpctoolkit
export HPCTOOLKIT_HPCSTRUCT_CACHE=`pwd`/hpcstruct-cache
