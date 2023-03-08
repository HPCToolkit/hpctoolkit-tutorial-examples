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
  module load gpu PrgEnv-gnu cudatoolkit cray-mpich cmake craype-x86-milan
  # modules for hpctoolkit
  module use /global/common/software/m3977/hpctoolkit/latest/perlmutter/modulefiles
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_BEFORE_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --pause"
  export HPCTOOLKIT_AFTER_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --resume"  
  export HPCTOOLKIT_PELEC_GPU_PLATFORM=cuda
  export HPCTOOLKIT_PELEC_MODULES_BUILD=""
  export HPCTOOLKIT_PELEC_GPUFLAGS="-DENABLE_CUDA=ON -DPELEC_ENABLE_CUDA=ON -DAMReX_CUDA_ARCH=8.0"
  export HPCTOOLKIT_PELEC_CXX_COMPILER=g++
  export HPCTOOLKIT_PELEC_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 20 -N 1 $HPCTOOLKIT_RESERVATION -C gpu"
  export HPCTOOLKIT_PELEC_RUN="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_PELEC_RUN_PC="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run-pc -o log.run-pc.out -e log.run-pc.error"
  export HPCTOOLKIT_PELEC_BUILD="sh"
  export HPCTOOLKIT_PELEC_LAUNCH="srun -n 1 -c 1 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=pelec

fi
