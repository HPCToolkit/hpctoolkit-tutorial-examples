if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'm3502' for cori users"
  echo "    'ntrain' for training accounts"
  echo "    'default' to run with your default repository, which won't let you use the  reservation"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'hpc1_gpu' for day 1"
  echo "    'hpc2_gpu' for day 2"
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

  # set up your environment to use cori's gpu nodes
  module purge
  module load cgpu

  # load hpctoolkit modules
  module load hpcviewer/2021.03.01

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/2021.03.01-gpu"

  # environment settings for this example
  export HPCTOOLKIT_MINIQMC_BUILD_MODULES="module load  llvm/12.0.0-git_20210117 cuda/11.1.1 cmake/3.18.2 gcc openblas"
  export HPCTOOLKIT_MINIQMC_COMPILER_FLAGS="-DENABLE_OFFLOAD=1"
  export HPCTOOLKIT_MINIQMC_CXX_COMPILER=clang
  export HPCTOOLKIT_MINIQMC_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -N 1 -c 10 -C gpu -t 10"
  export HPCTOOLKIT_MINIQMC_RUN="$HPCTOOLKIT_MINIQMC_SUBMIT -J qs-run -o log.run.out -e log.run.error -G 1"
  export HPCTOOLKIT_MINIQMC_RUN_PC="$HPCTOOLKIT_MINIQMC_SUBMIT -J qs-run-pc -o log.run-pc.out -e log.run-pc.error -G 1"
  export HPCTOOLKIT_MINIQMC_BUILD="$HPCTOOLKIT_MINIQMC_SUBMIT -J qs-build -o log.build.out -e log.build.error"
  export HPCTOOLKIT_MINIQMC_BUILD="sh make-scripts/unsupported.sh"
  export HPCTOOLKIT_MINIQMC_LAUNCH="srun -n 1 -G 1"

  # set flag for this example
  export HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY=1

  # unset flags for other examples
  unset HPCTOOLKIT_TUTORIAL_CPU_AMG2013_READY
  unset HPCTOOLKIT_TUTORIAL_CPU_HPCG_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAMMPS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
fi
