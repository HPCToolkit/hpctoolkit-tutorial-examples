if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project ID for submitting jobs"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to hpctoolkit1 for Day 1 (3/29) and hpctoolkit2 for Day 2 (4/2)"
  echo "if set to default, then the job will be submitted the default batch queue"
else
  # set up your environment
  module purge
  module load hpctoolkit/2021.03.01
  module load hpcviewer/2021.03.01
  module load cuda/11.0.2
  module load gcc/6.4.0
  module load cmake/3.17.3
  module load spectrum-mpi

  # environment settings for this example
  export HPCTOOLKIT_LAMMPS_MODULES_BUILD=""
  export HPCTOOLKIT_LAMMPS_MODULES_HPCTOOLKIT="module load hpctoolkit/2021.03.01"
  export HPCTOOLKIT_LAMMPS_SUBMIT="bsub $HPCTOOLKIT_PROJECTID -W 5 -nnodes 1 $HPCTOOLKIT_RESERVATION"
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
  unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY
fi
