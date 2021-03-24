module load cuda/11.1.1
module use /global/common/software/m1759/hpctoolkit-install/2021.03/modules
module load hpctoolkit/2021.03-gpu
module load cmake
module load gcc
module load openmpi
export HPCTOOLKIT_LAUNCHER_SINGLE_GPU="srun -n 1 -G 1"

unset HPCTOOLKIT_TUTORIAL_GPU_LAMMMPS_READY
unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY
unset HPCTOOLKIT_TUTORIAL_BATCH
export HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY=1
