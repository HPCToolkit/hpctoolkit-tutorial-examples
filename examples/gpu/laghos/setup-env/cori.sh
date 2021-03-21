module load cuda/11.1.1
module use /global/common/software/m1759/hpctoolkit-install/2021.03/modules
module load hpctoolkit/2021.03-gpu
module load cmake
module load gcc
module load openmpi
export HPCTOOLKIT_LAUNCHER_SINGLE_GPU="srun -n 1 -G 1"
