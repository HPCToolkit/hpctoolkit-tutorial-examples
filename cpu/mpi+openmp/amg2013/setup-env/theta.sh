if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'default' to run with your default repository, which won't let you use the  reservation"
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
    export HPCTOOLKIT_RESERVATION="-q $HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi
  export HPCTOOLKIT_AMG2013_BUILD=sh
  export HPCTOOLKIT_AMG2013_RUN=sh
  export HPCTOOLKIT_AMG2013_ANALYZE=sh
  export HPCTOOLKIT_AMG2013_ANALYZE_PARALLEL=sh
  export HPCTOOLKIT_AMG2013_VIEW=sh
  export HPCTOOLKIT_AMG2013_CLEAN_CMD="/bin/rm -rf *.output *.error *.cobaltlog *.done"

  export HPCTOOLKIT_MPI_CC=cc
  export HPCTOOLKIT_RUN_CMD="job-scripts/amg2013-theta"
  export HPCTOOLKIT_ANALYZE_CMD="job-scripts/profmpi-theta"
  export HPCTOOLKIT_BATCH="qsub $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION" 

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=amg2013
fi
