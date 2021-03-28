module load hpctoolkit/2021.03.01
module load cuda/11.0.2
module load gcc/6.4.0
module load cmake/3.17.3
module load spectrum-mpi
export HPCTOOLKIT_LAUNCHER_SINGLE_GPU="jsrun -n 1 -g 1 -a 1"
