export HPCTOOLKIT_TUTORIAL_PROJECTID=default
export HPCTOOLKIT_TUTORIAL_RESERVATION=default
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
  module use /projects/hpctoolkit/modulefiles/ppc64le
  module load hpctoolkit/2022.04

  # load modules needed to build and run quicksilver
  module load cuda/11.6.0 cmake/3.14.5 gcc/8.3.1

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT=""

    # environment settings for this example
  export HPCTOOLKIT_QS_MODULES_BUILD=""
  export HPCTOOLKIT_QS_SUBMIT="bsub $HPCTOOLKIT_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_QS_RUN="$HPCTOOLKIT_QS_SUBMIT -J qs-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_QS_RUN_PC="$HPCTOOLKIT_QS_SUBMIT -J qs-run-pc -o log.run-pc.out -e log.run-pc.error"
  export HPCTOOLKIT_QS_BUILD="sh"
  export HPCTOOLKIT_QS_LAUNCH="jsrun -n 1 -g 1 -a 1"

  # set flag for this example
  export HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY=1

  # unset flags for other examples
  unset HPCTOOLKIT_TUTORIAL_CPU_AMG2013_READY
  unset HPCTOOLKIT_TUTORIAL_CPU_HPCG_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAMMPS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LULESH_ACC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LULESH_OMP_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
fi


