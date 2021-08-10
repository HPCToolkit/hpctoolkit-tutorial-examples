if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then 
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value"
  echo "    or 'default' to run without a reservation"
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
  module use /ccsopen/proj/gen161/modules
  module load hpctoolkit/2021.08.10

  # load modules needed to build and run lammps
  module load cuda/10.1.243 gcc/7.4.0 cmake/3.18.2 spectrum-mpi

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT=""

  # environment settings for this example
  export HPCTOOLKIT_LAMMPS_MODULES_BUILD=""
  export HPCTOOLKIT_LAMMPS_SUBMIT="bsub $HPCTOOLKIT_PROJECTID -W 20 -nnodes 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LAMMPS_RUN="$HPCTOOLKIT_LAMMPS_SUBMIT -J lammps-run -o log.run.out -e log.run.error -G 1"
  export HPCTOOLKIT_LAMMPS_RUN_PC="$HPCTOOLKIT_LAMMPS_SUBMIT -J lammps-run-pc -o log.run-pc.out -e log.run-pc.error -G 1"
  export HPCTOOLKIT_LAMMPS_BUILD="sh"
  export HPCTOOLKIT_LAMMPS_LAUNCH="jsrun -n 1 -g 1 -a 1"

  # set flag for this example
  export HPCTOOLKIT_TUTORIAL_GPU_LAMMPS_READY=1

  # unset flags for other examples
  unset HPCTOOLKIT_TUTORIAL_CPU_AMG2013_READY
  unset HPCTOOLKIT_TUTORIAL_CPU_HPCG_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LULESH_ACC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LULESH_OMP__READY
  unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
fi
