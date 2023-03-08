export HPCTOOLKIT_TUTORIAL_RESERVATION=default

if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
#  echo "    'hpctoolkit1' for day 1"
#  echo "    'hpctoolkit2' for day 2"
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
    export HPCTOOLKIT_RESERVATION="--reservation=$HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  # cleanse environment
  module purge

  # load modules needed to build and run pelec
  module load gpu PrgEnv-nvidia nvidia/22.7 cray-mpich

  # modules for hpctoolkit
  module use /global/common/software/m3977/hpctoolkit/latest/perlmutter/modulefiles
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_CUDA_ARCH=80
  export HPCTOOLKIT_MPI_CC=cc
  export HPCTOOLKIT_MPI_CXX=CC
  export HPCTOOLKIT_BEFORE_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --pause"
  export HPCTOOLKIT_AFTER_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --resume"
  export HPCTOOLKIT_LAGHOS_MODULES_BUILD=""
  export HPCTOOLKIT_LAGHOS_C_COMPILER=nvc
  export HPCTOOLKIT_LAGHOS_MFEM_FLAGS="pcuda CUDA_ARCH=sm_$HPCTOOLKIT_CUDA_ARCH BASE_FLAGS='-std=c++11 -g'"
  export HPCTOOLKIT_LAGHOS_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 5 -N 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LAGHOS_RUN_SHORT="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-short -o log.run-short.out -e log.run-short.error"
  export HPCTOOLKIT_LAGHOS_RUN_LONG="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-long -o log.run-long.out -e log.run-long.error"
  export HPCTOOLKIT_LAGHOS_RUN_PC="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-pc -o log.run-pc.out -e log.run-pc.error"
  export HPCTOOLKIT_LAGHOS_BUILD="sh"
  export HPCTOOLKIT_LAGHOS_LAUNCH="srun -n 4 -c 1 --gpus-per-node=4 --gpu-bind=closest"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=laghos

fi
