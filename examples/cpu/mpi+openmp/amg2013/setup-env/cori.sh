if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'm3502' for cori users" 
  echo "    'ntrain' for training accounts"
  echo "    'default' to run with your default repository, which won't let you use the  reservation"
elif [ -z "$HPCTOOLKIT_TUTORIAL_RESERVATION" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_RESERVATION to an appropriate value:"
  echo "    'hpc1_knl' for day 1" 
  echo "    'hpc2_knl' for day 2"
  echo "    'default' to run without the reservation"
else
  if test "$HPCTOOLKIT_TUTORIAL_PROJECTID" != "default"
  then
    export HPCTOOLKITL_PROJECTID="-A $HPCTOOLKIT_TUTORIAL_PROJECTID"
  else
    unset HPCTOOLKITL_PROJECTID
  fi
  if test "$HPCTOOLKIT_TUTORIAL_RESERVATION" != "default"
  then
    export HPCTOOLKIT_RESERVATION="--reservation=$HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi
  export HPCTOOLKIT_MPI_CC=cc
  export HPCTOOLKIT_RUN_CMD="job-scripts/amg2013-cori"
  export HPCTOOLKIT_ANALYZE_CMD="job-scripts/profmpi-cori"
  export HPCTOOLKIT_CLEAN_CMD="/bin/rm -rf *.output *.error"
  export HPCTOOLKIT_BATCH="sbatch $HPCTOOLKITL_PROJECTID $HPCTOOLKIT_RESERVATION" 
  export HPCTOOLKIT_SETUP=amg2013
  export HPCTOOLKIT_TUTORIAL_GPU_AMG2013_READY
fi
