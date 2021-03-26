if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'hpctoolkit1' for day 1"
  echo "    'hpctoolkit2' for day 2"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-P $HPCTOOLKIT_TUTORIAL_PROJECTID"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="-U $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  module purge
  module load python
  module load hpctoolkit/2021.03.01
  module load cuda/11.0.2
  module load gcc/6.4.0
  module load cmake/3.17.3
  module load spectrum-mpi

  # set platform
  unset HPCTOOLKIT_TUTORIAL_GPU_PLATFORM
  export HPCTOOLKIT_TUTORIAL_GPU_PLATFORM=summit

  # environment settings for this example
  export HPCTOOLKIT_PELEC_MODULES_BUILD=""
  export HPCTOOLKIT_PELEC_MODULES_HPCTOOLKIT="module load hpctoolkit/2021.03.01"
  export HPCTOOLKIT_PELEC_SUBMIT="bsub $HPCTOOLKIT_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_PELEC_RUN="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run -o log.run.out -e log.run.error -G 1"
  export HPCTOOLKIT_PELEC_RUN_PC="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-run-pc -o log.run-pc.out -e log.run-pc.error -G 1"
  export HPCTOOLKIT_PELEC_BUILD="$HPCTOOLKIT_PELEC_SUBMIT -J pelec-build -o log.build.out -e log.build.error"
  export HPCTOOLKIT_PELEC_LAUNCH="jsrun -n 1 -g 1 -a 1 --smpiargs=\"-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks\""

  # set flag for this example
  export HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY=1

  # unset flags for other examples
  unset HPCTOOLKIT_TUTORIAL_CPU_AMG2013_READY
  unset HPCTOOLKIT_TUTORIAL_CPU_HPCG_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAMMPS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY
fi
