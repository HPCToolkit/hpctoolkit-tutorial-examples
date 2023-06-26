if [ -z "$READY" ]
then
  echo
  echo "*******************************************************************************"
  echo "* Before using make, you must source the setup script for this machine in the *"
  echo "* setup-env subdirectory:                                                     *"
  echo "*     source setup-env/<machine>.sh                                           *" 
  echo "*******************************************************************************"
  echo
  exit
fi

$CMD $1
