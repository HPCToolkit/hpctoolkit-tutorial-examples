module load cuda/11.1.1
module load hpctoolkit/2021.03-gpu
module load cmake
module load gcc
module load mpich
export HPCTOOLKIT_LAUNCHER_SINGLE_GPU="srun -n 1 -G 1"
