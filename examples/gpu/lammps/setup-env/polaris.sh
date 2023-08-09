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
    export HPCTOOLKIT_RESERVATION="-q $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    # If no reservation is set, use the debug queue
    export HPCTOOLKIT_RESERVATION="-q debug"
  fi
  
  # cleanse environment
  module reset

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /soft/perftools/hpctoolkit/polaris/modulefiles"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT
  
  # load modules needed to build and run lammps
  module load PrgEnv-gnu cray-mpich cmake craype-x86-milan cudatoolkit-standalone/11.4.4
  export CUDA_HOME=/soft/compilers/cudatoolkit/cuda-11.4.4

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /soft/perftools/hpctoolkit/polaris/modulefiles"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_LAMMPS_ROOT="$(pwd)"
  export HPCTOOLKIT_LAMMPS_MODULES_BUILD=""
  export HPCTOOLKIT_LAMMPS_GPU_ARCH="-DKokkos_ARCH_AMPERE80=ON"
  export HPCTOOLKIT_LAMMPS_HOST_ARCH="-DKokkos_ARCH_ZEN3=ON"
  export HPCTOOLKIT_LAMMPS_GPUFLAGS="-DKokkos_ENABLE_CUDA=yes -DCMAKE_CXX_COMPILER=$(pwd)/lammps/lammps/lib/kokkos/bin/nvcc_wrapper -DCMAKE_CXX_FLAGS=\"-lineinfo -ccbin $(which CC)\""
  export HPCTOOLKIT_LAMMPS_SUBMIT="qsub $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -l select=1 -l walltime=0:10:00 -l filesystems=home:grand -V"
  export HPCTOOLKIT_LAMMPS_RUN="$HPCTOOLKIT_LAMMPS_SUBMIT -N lammps-run -o log.run.out -e log.run.error"
  export HPCTOOLKIT_LAMMPS_RUN_PC="$HPCTOOLKIT_LAMMPS_SUBMIT -N lammps-run -o log.run-pc.out -e log.run-pc.error"
  export HPCTOOLKIT_LAMMPS_BUILD="sh"
  export HPCTOOLKIT_LAMMPS_OMP_NUM_THREADS=16
  export HPCTOOLKIT_LAMMPS_LAUNCH="mpiexec -n 4 -ppn 4 --depth=8 --cpu-bind depth sh make-scripts/set_affinity_gpu_polaris.sh"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=lammps

fi
