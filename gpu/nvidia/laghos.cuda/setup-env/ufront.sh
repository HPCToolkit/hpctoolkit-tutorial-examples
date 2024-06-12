# configure default setup for users
unset HPCTOOLKIT_PROJECTID
unset HPCTOOLKIT_RESERVATION

export QA_TEST_VARIANT=".cuda"

# module use /home/johnmc/spack/share/spack/modules/linux-rhel8-zen
module use /projects/modulefiles
export CUPTI_DEVICE_NUM=1
export CUPTI_SAMPLING_PERIOD=5

export HPCTOOLKIT_GPU_PLATFORM=nvidia
export HPCTOOLKIT_CUDA_ARCH="''sm_80 -lineinfo''"
# environment settings for this example
export HPCTOOLKIT_LAGHOS="$(pwd)"

export HPCTOOLKIT_LAGHOS_MODULES_BUILD="module load cuda/12.2 cmake/3.15.7 openmpi/4.1.5/cuda-12.2.1 "
export HPCTOOLKIT_LAGHOS_SUBMIT="sh"
export HPCTOOLKIT_LAGHOS_RUN_SHORT="sh"
export HPCTOOLKIT_LAGHOS_RUN_LONG="sh -n 1 "
export HPCTOOLKIT_LAGHOS_RUN_PC="sh -n 1 "
export HPCTOOLKIT_LAGHOS_BUILD="sh"
export HPCTOOLKIT_LAGHOS_LAUNCH="mpirun -n 1"

# mark configuration for this example
export HPCTOOLKIT_EXAMPLE=laghos
