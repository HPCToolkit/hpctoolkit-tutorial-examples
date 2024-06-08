# configure default setup for users
export HPCTOOLKIT_TUTORIAL_PROJECTID=default
export HPCTOOLKIT_TUTORIAL_RESERVATION=default

if [ -z "$HPCTOOLKIT_TUTORIAL_PROJECTID" ]
then
  echo "Please set environment variable HPCTOOLKIT_TUTORIAL_PROJECTID to the apppropriate repository:"
  echo "    'ntrain' for training accounts"
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
    export HPCTOOLKIT_RESERVATION="--reservation=$HPCTOOLKIT_TUTORIAL_RESERVATION"
  else
    unset HPCTOOLKIT_RESERVATION
  fi

  # unload darshan
  module unload darshan

  # load hpctoolkit modules
  module use /global/common/software/m3977/hpctoolkit/2021-11/modules
  module load hpctoolkit/2021.11-cpu

  export HPCTOOLKIT_LULESH_BUILD=sh
  export HPCTOOLKIT_LULESH_ANALYZE=sh
  export HPCTOOLKIT_LULESH_RUN=sh
  export HPCTOOLKIT_LULESH_VIEW=sh
  export HPCTOOLKIT_RUN_CMD="job-scripts/lulesh-cori"
  export HPCTOOLKIT_ANALYZE_CMD="job-scripts/profmpi-cori"
  export HPCTOOLKIT_CLEAN_CMD="/bin/rm -rf *.output *.error"
  export HPCTOOLKIT_BATCH="sbatch $HPCTOOLKIT_PROJECTID $HPCTOOLKIT_RESERVATION" 

  # mark configuration for this example
  export HPCTOOLKIT_EXAMPLE=lulesh
fi
