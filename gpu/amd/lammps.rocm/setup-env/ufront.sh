# load modules needed to build and run lammps
module use /projects/modulefiles
module use /usr/local/modules
# module load rocm/5.6.0
# module load cmake

# modules for hpctoolkit
# module use /home/johnmc/modulefiles
# export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/msi3"
$HPCTOOLKIT_MODULES_HPCTOOLKIT

# environment settings for this example
export HPCTOOLKIT_GPU_PLATFORM=amd
export HPCTOOLKIT_LAMMPS_ROOT="$(pwd)"
export HPCTOOLKIT_LAMMPS_MODULES_BUILD=""
export HPCTOOLKIT_LAMMPS_GPU_ARCH="-DKokkos_ARCH_VEGA90A=ON"
export HPCTOOLKIT_LAMMPS_HOST_ARCH="-DKokkos_ARCH_ZEN1=ON"
export HPCTOOLKIT_LAMMPS_GPUFLAGS="-DKokkos_ENABLE_HIP=yes -DCMAKE_CXX_COMPILER=$(which hipcc) -DCMAKE_CXX_FLAGS=\"-g\""
export HPCTOOLKIT_LAMMPS_SUBMIT="sh"
export HPCTOOLKIT_LAMMPS_RUN="env ROCR_VISIBLE_DEVICES=1,2 sh"
export HPCTOOLKIT_LAMMPS_RUN_PC="sh make-scripts/unsupported-amd.sh"
export HPCTOOLKIT_LAMMPS_BUILD="sh"
export HPCTOOLKIT_LAMMPS_OMP_NUM_THREADS=1
export HPCTOOLKIT_LAMMPS_LAUNCH="mpirun -np 1"
export QA_TEST_VARIANT=".rocm"

# mark configuration for this example
export HPCTOOLKIT_EXAMPLE=lammps
