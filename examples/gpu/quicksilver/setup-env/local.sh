# a simple model setup file that will build and run quicksilver
# on the current node

# assumption: you have the following module files below available
# quicksilver doesn't require cmake/3.15.7; that was just the
# one available.

# NOTE: don't use CUDA >= 11.2. hpctoolkit doesn't yet analyze
# CUDA 11.2 binaries.

# load hpctoolkit modules
module use /projects/modulefiles
module load hpcviewer/2021.03
module load hpctoolkit/2021.03
module load cuda/11.1 
module load cmake/3.15.7

# modules for hpctoolkit
export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/2021.03"

# environment settings for this example
export HPCTOOLKIT_QS_MODULES_BUILD=""
export HPCTOOLKIT_QS_SUBMIT="sh"
export HPCTOOLKIT_QS_RUN="sh"
export HPCTOOLKIT_QS_RUN_PC="sh"
export HPCTOOLKIT_QS_BUILD="sh"
export HPCTOOLKIT_QS_LAUNCH="sh"

# set flag for this example
export HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY=1

# unset flags for other examples
unset HPCTOOLKIT_TUTORIAL_CPU_AMG2013_READY
unset HPCTOOLKIT_TUTORIAL_CPU_HPCG_READY
unset HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY
unset HPCTOOLKIT_TUTORIAL_GPU_LAMMPS_READY
unset HPCTOOLKIT_TUTORIAL_GPU_LULESH_ACC_READY
unset HPCTOOLKIT_TUTORIAL_GPU_LULESH_OMP_READY
unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
