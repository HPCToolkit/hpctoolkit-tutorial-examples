if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project ID for submitting jobs"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to hpctoolkit1 for Day 1 (3/29) and hpctoolkit2 for Day 2 (4/2)"
  echo "if set to default, then the job will be submitted the default batch queue"
else
  module purge
  module load python
  module load hpctoolkit/2021.03.01
  module load cuda/11.0.2
  module load gcc/6.4.0
  module load cmake/3.17.3
  module load spectrum-mpi

  unset HPCTOOLKIT_TUTORIAL_GPU_LAMMMPS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY
  unset HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY

  export HPCTOOLKIT_TUTORIAL_BATCH=1
  export HPCTOOLKIT_TUTORIAL_GPU_PELEC_READY=1
  unset HPCTOOLKIT_TUTORIAL_GPU_PLATFORM
  export HPCTOOLKIT_TUTORIAL_GPU_PLATFORM=summit
fi
