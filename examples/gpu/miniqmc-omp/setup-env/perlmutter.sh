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
    export HPCTOOLKIT_RESERVATION="--reservation=$HPCTOOLKIT_TUTORIAL_RESERVATION -q shared"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  # cleanse environment
  module reset

  # load modules needed to build and run miniqmc
  module load gpu PrgEnv-nvidia nvidia/23.9 cmake cray-libsci

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /global/common/software/m3977/modulefiles/perlmutter"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_BEFORE_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --pause"
  export HPCTOOLKIT_AFTER_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --resume"
  export HPCTOOLKIT_MINIQMC_CXX_COMPILER=nvc++
  export HPCTOOLKIT_MINIQMC_GPUFLAGS="-DENABLE_OFFLOAD=1 -DOFFLOAD_ARCH=cc80"
  export HPCTOOLKIT_MINIQMC_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -N 1 -t 30 -C gpu"
  export HPCTOOLKIT_MINIQMC_RUN="$HPCTOOLKIT_MINIQMC_SUBMIT -J miniqmc-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_MINIQMC_RUN_PC="$HPCTOOLKIT_MINIQMC_SUBMIT -J miniqmc-run-pc -o log.run-pc.out -e log.run-pc.error $1"
  export HPCTOOLKIT_MINIQMC_BUILD="sh"
  export HPCTOOLKIT_MINIQMC_LAUNCH="srun -n 1 -c 32 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=miniqmc
fi
