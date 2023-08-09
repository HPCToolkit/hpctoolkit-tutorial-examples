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
    export HPCTOOLKIT_PROJECTID="-A $HPCTOOLKIT_TUTORIAL_PROJECTID"
  else
    unset HPCTOOLKIT_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="--reservation=$HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  # cleanse environment
  module purge

  # load modules needed to build and run lulesh
  module load gpu PrgEnv-nvidia cray-mpich libfabric craype-x86-milan craype-accel-nvidia80

  # modules for hpctoolkit
  export HPCTOOLKIT_MODULES_USE="module use /global/common/software/m3977/modulefiles/perlmutter"
  export HPCTOOLKIT_MODULES_HPCTOOLKIT="module load hpctoolkit/default"
  $HPCTOOLKIT_MODULES_USE
  $HPCTOOLKIT_MODULES_HPCTOOLKIT

  # environment settings for this example
  export HPCTOOLKIT_GPU_PLATFORM=nvidia
  export HPCTOOLKIT_BEFORE_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --pause"
  export HPCTOOLKIT_AFTER_RUN_PC="srun --ntasks-per-node 1 dcgmi profile --resume"  
  export HPCTOOLKIT_LULESH_ACC_MODULES_BUILD=""
  export HPCTOOLKIT_LULESH_ACC_CXX=nvc++
  export HPCTOOLKIT_LULESH_ACC_ACCFLAGS="-acc -Minfo=accel"
  export HPCTOOLKIT_LULESH_ACC_CXXFLAGS="-DUSE_MPI=0 -DSEDOV_SYNC_POS_VEL_LATE -fast -gopt -Mautoinline -Minline=levels:20 ${HPCTOOLKIT_LULESH_ACC_ACCFLAGS}"
  export HPCTOOLKIT_LULESH_ACC_SUBMIT="sbatch $HPCTOOLKIT_PROJECTID -t 10 -N 1 $HPCTOOLKIT_RESERVATION -C gpu"
  export HPCTOOLKIT_LULESH_ACC_RUN="$HPCTOOLKIT_LULESH_ACC_SUBMIT -J lulesh-run -o log.run.out -e log.run.error -G 1"
  export HPCTOOLKIT_LULESH_ACC_RUN_PC="$HPCTOOLKIT_LULESH_ACC_SUBMIT -J lulesh-run-pc -o log.run-pc.out -e log.run-pc.error -G 1"
  export HPCTOOLKIT_LULESH_ACC_BUILD="sh"
  export HPCTOOLKIT_LULESH_ACC_LAUNCH="srun -n 1 -c 1 -G 1"

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=luleshacc

fi
