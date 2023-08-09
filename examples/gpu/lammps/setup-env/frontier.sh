if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to your project id"
  echo "    'default' to run with your default project id unset"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then 
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-A ${HPCTOOLKIT_TUTORIAL_PROJECTID}"
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

  # load modules needed to build and run lammps
  module load PrgEnv-amd amd/5.4.3 cray-mpich craype-x86-trento craype-accel-amd-gfx90a cmake

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load ums ums023 hpctoolkit"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=amd
  export HPCTOOLKIT_LAMMPS_ROOT="$(pwd)"
  export HPCTOOLKIT_LAMMPS_MODULES_BUILD=""
  export HPCTOOLKIT_LAMMPS_GPU_ARCH="-DKokkos_ARCH_VEGA90A=ON"
  export HPCTOOLKIT_LAMMPS_HOST_ARCH="-DKokkos_ARCH_ZEN3=ON"
  export HPCTOOLKIT_LAMMPS_GPUFLAGS="-DKokkos_ENABLE_HIP=yes -DCMAKE_CXX_COMPILER=$(which hipcc) -DCMAKE_CXX_FLAGS=\"-g\""
  export HPCTOOLKIT_LAMMPS_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 20 -N 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LAMMPS_RUN="$HPCTOOLKIT_LAMMPS_SUBMIT -J lammps-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_LAMMPS_RUN_PC="sh make-scripts/unsupported-amd.sh"
  export HPCTOOLKIT_LAMMPS_BUILD="sh"
  export HPCTOOLKIT_LAMMPS_OMP_NUM_THREADS=7
  export HPCTOOLKIT_LAMMPS_LAUNCH="srun --ntasks-per-node=8 --gpus-per-task=1 --gpu-bind=closest -c 7"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=lammps

fi
