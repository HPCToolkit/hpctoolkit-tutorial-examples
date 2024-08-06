


if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate project:"
  echo "    'default' to run with your default project, which won't let you use the reservation"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'default' to run in the debug queue without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKIT_PROJECTID="-A $HPCTOOLKIT_TUTORIAL_PROJECTID"
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

  module load  gcc-native-mixed/12.3

  #kokkos settings
  export Kokkos_DIR=`pwd`/kokkos/kokkos-install-cuda/lib64/cmake

  #ArborX settings
  export ArborX_DIR=`pwd`/ArborX/work/prgenv-gnu/install/lib/cmake
  export ArborX_DIR=`pwd`/ArborX/work/prgenv-gnu/install/lib/cmake
  export OMP_PROC_BIND=spread
  export OMP_PLACES=threads

  #hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /soft/modulefiles"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit"
  export HPCTOOLKIT_HPCSTRUCT_CACHE=$HOME/.hpctoolkit/hpcstruct-cache
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  export HPCTOOLKIT_ARBORX_ROOT="$(pwd)"
  export HPCTOOLKIT_ARBORX_SUBMIT="qsub $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION -l select=1 -l walltime=0:10:00 -l filesystems=home:grand:eagle -V"
  export HPCTOOLKIT_ARBORX_RUN="$HPCTOOLKIT_ARBORX_SUBMIT -N arborx-run -o log.run.out -e log.run.stderr"
  export HPCTOOLKIT_ARBORX_RUN_PC="$HPCTOOLKIT_ARBORX_SUBMIT -N arborx-run-pc -o log.run-pc.out -e log.run-pc.stderr"
  export HPCTOOLKIT_ARBORX_BUILD="sh"
  export HPCTOOLKIT_ARBORX_LAUNCH="mpiexec -n 4 -ppn 4 --depth=8 --cpu-bind depth sh make-scripts/set_affinity_gpu_polaris.sh"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=ArborX
fi
