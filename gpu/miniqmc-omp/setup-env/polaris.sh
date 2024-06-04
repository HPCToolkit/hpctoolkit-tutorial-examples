if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'ntrain' for training accounts"
  echo "    'default' to run with your default repository, which won't let you use the reservation"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-A $HPCTOOLKIT_TUTORIAL_PROJECTID"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="-q $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    # If no reservation is set, use the debug queue
    export HPCTOOLKIT_RESERVATION="-q debug"
  fi

  # cleanse environment
  module reset

  # load modules needed to build and run miniqmc
  module load PrgEnv-nvhpc nvhpc/23.3 cmake craype-x86-milan craype-accel-nvidia80 cray-libsci
  unset CUDA_HOME NVHPC_CUDA_HOME
  export NVHPC_CUDA_HOME=/opt/nvidia/hpc_sdk/Linux_x86_64/23.3/cuda/11.8

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /soft/perftools/hpctoolkit/polaris/modulefiles"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_MINIQMC_ROOT="$(pwd)"
  export HPCTOOLKIT_MINIQMC_CXX_COMPILER=CC
  export HPCTOOLKIT_MINIQMC_GPUFLAGS="-DENABLE_OFFLOAD=1 -DOFFLOAD_ARCH=cc80 -DQMC_MPI=ON -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment"
  export HPCTOOLKIT_MINIQMC_SUBMIT="qsub $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -l select=1 -l walltime=0:10:00 -l filesystems=home:grand:eagle -V"
  export HPCTOOLKIT_MINIQMC_RUN="$HPCTOOLKIT_MINIQMC_SUBMIT -N miniqmc-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_MINIQMC_RUN_PC="$HPCTOOLKIT_MINIQMC_SUBMIT -N miniqmc-run-pc -o log.run-pc.out -e log.run-pc.error $1"
  export HPCTOOLKIT_MINIQMC_BUILD="sh"
  export HPCTOOLKIT_MINIQMC_LAUNCH="mpiexec -n 4 -ppn 4 --depth=8 --cpu-bind depth sh make-scripts/set_affinity_gpu_polaris.sh"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=miniqmc
fi
