if [ -z "$HPCTOOLKIT_TUTORIAL_GPU_LAMMPS_READY" ]
then
  echo "Please first source a script under setup-env directory based on the cluster your are using"
  exit
fi

if [ -z "$HPCTOOLKIT_TUTORIAL_BATCH" ]
then
  sbatch -A $HPCTOOLKIT_TUTORIAL_PROJECTID 
else
  if [ $HPCTOOLKIT_TUTORIAL_RESERVATION == "default" ]
  then
     RESERVE=""
  else
     RESERVE="-U $HPCTOOLKIT_TUTORIAL_RESERVATION"
  fi
  bsub -P $HPCTOOLKIT_TUTORIAL_PROJECTID -W 5 -nnodes 1 $RESERVE -J $JOBNAME -o output.$JOBNAME -e error.$JOBNAME $1 
fi
