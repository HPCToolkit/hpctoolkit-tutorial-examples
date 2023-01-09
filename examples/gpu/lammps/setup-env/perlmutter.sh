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
    export HPCTOOLKIT_RESERVATION="-U $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi
  
  # cleanse environment
  module purge

  # load modules needed to build and run lammps
  module load gpu PrgEnv-gnu cudatoolkit cray-mpich cmake

  # modules for hpctoolkit
  module use /global/common/software/m3977/hpctoolkit/latest/perlmutter/modulefiles
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_BEFORE_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --pause"
  export HPCTOOLKIT_AFTER_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --resume"  
  export HPCTOOLKIT_LAMMPS_MODULES_BUILD=""
  export HPCTOOLKIT_LAMMPS_GPU_ARCH="-DKokkos_ARCH_GPUARCH=AMPERE80 -DKokkos_ARCH_AMPERE80=ON"
  export HPCTOOLKIT_LAMMPS_HOST_ARCH="-DKokkos_ARCH_HOSTARCH=ZEN3"
  export HPCTOOLKIT_LAMMPS_GPUFLAGS="-DKokkos_ENABLE_CUDA=yes -DCMAKE_CXX_COMPILER=$(pwd)/lammps/lammps/lib/kokkos/bin/nvcc_wrapper -DCMAKE_CXX_FLAGS=\"-lineinfo\""
  export HPCTOOLKIT_LAMMPS_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 20 -N 1 $HPCTOOLKIT_RESERVATION"
  export HPCTOOLKIT_LAMMPS_RUN="$HPCTOOLKIT_LAMMPS_SUBMIT -J lammps-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_LAMMPS_RUN_PC="$HPCTOOLKIT_LAMMPS_SUBMIT -J lammps-run-pc -o log.run-pc.out -e log.run-pc.error"
  export HPCTOOLKIT_LAMMPS_BUILD="sh"
  export HPCTOOLKIT_LAMMPS_LAUNCH="srun -n 1 -G 1 -c 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=lammps

fi
