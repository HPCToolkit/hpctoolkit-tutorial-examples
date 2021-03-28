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

  # cleanse environment
  module purge

  # load hpctoolkit modules
  module load hpctoolkit/2021.03.01
  module load hpcviewer/2021.03

  # load modules needed to build and run laghos
  module load cuda/11.0.2 gcc/6.4.0 cmake/3.17.3 spectrum-mpi

  # set platform
  unset HPCTOOLKIT_TUTORIAL_GPU_PLATFORM
  export HPCTOOLKIT_TUTORIAL_GPU_PLATFORM=summit

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT=""

  # environment settings for this example
  export HPCTOOLKIT_LAGHOS_MODULES_BUILD=""
  export HPCTOOLKIT_LAGHOS_SUBMIT="bsub $HPCTOOLKIT_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LAGHOS_RUN_SHORT="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-short -o log.run-short.out -e log.run-short.error -G 1"
  export HPCTOOLKIT_LAGHOS_RUN_LONG="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-long -o log.run-long.out -e log.run-long.error -G 1"
  export HPCTOOLKIT_LAGHOS_RUN_PC="$HPCTOOLKIT_LAGHOS_SUBMIT -J laghos-run-pc -o log.run-pc.out -e log.run-pc.error -G 1"
  export HPCTOOLKIT_LAGHOS_BUILD="sh"
  export HPCTOOLKIT_LAGHOS_LAUNCH="jsrun -n 1 -g 1 -a 1"


  # set flag for this example
  export HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY=1

  # unset flags for other examples
  unset HPCTOOLKIT_TUTORIAL_CPU_AMG2013_READY
  unset HPCTOOLKIT_TUTORIAL_CPU_HPCG_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAMMPS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY
fi
