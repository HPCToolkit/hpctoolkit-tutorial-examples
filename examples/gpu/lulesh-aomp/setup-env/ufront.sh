# modules for hpctoolkit
export HPCTOOLKIT_MODULES_HPCTOOLKIT=""

# environment settings for this example
export HPCTOOLKIT_LULESH_OMP_MODULES_BUILD=""
export HPCTOOLKIT_LULESH_OMP_CXX="/home/johnmc/rocm/aomp/bin/clang -DUSE_MPI=0" 
export HPCTOOLKIT_LULESH_OMP_OMPFLAGS="-O3 -target x86_64-pc-linux-gnu -fopenmp -fopenmp-targets=amdgcn-amd-amdhsa -Xopenmp-target=amdgcn-amd-amdhsa -march=gfx906"
export HPCTOOLKIT_LULESH_OMP_OMPFLAGS="-O3 -g -target x86_64-pc-linux-gnu -fopenmp -fopenmp-targets=amdgcn-amd-amdhsa -Xopenmp-target=amdgcn-amd-amdhsa -march=gfx906"
export HPCTOOLKIT_LULESH_OMP_SUBMIT="sh"
export HPCTOOLKIT_LULESH_OMP_RUN="sh"
export HPCTOOLKIT_LULESH_OMP_RUN_PC="$sh"
export HPCTOOLKIT_LULESH_OMP_BUILD="sh"
export HPCTOOLKIT_LULESH_OMP_LAUNCH="sh"

# set flag for this example
export HPCTOOLKIT_TUTORIAL_GPU_LULESH_OMP_READY=1

# unset flags for other examples
unset HPCTOOLKIT_TUTORIAL_CPU_AMG2013_READY
unset HPCTOOLKIT_TUTORIAL_CPU_HPCG_READY
unset HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY
unset HPCTOOLKIT_TUTORIAL_GPU_LAMMPS_READY
unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY
