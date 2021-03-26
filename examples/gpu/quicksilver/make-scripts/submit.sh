if [ -z "$HPCTOOLKIT_TUTORIAL_GPU_QUICKSILVER_READY" ]
then
  echo "Please first source a script under setup-env directory based on the cluster your are using"
  exit
fi

$SUBMIT $1 
