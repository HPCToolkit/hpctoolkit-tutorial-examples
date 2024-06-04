BINARY=amg2013
EXEC=AMG2013/test/${BINARY}
OUT=hpctoolkit-amg2013


if [[ -z "`type -p hpcprof-mpi`" ]] 
then
  if [[ -z "`type -p hpcrun`" ]]
  then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
  else
    ver="$(hpcrun -V | head -n 1 | sed 's/.*version //')"
    if [[ "$ver" =~ "2022.10.01-release" ]]
    then
      echo "hpcprof-mpi is disabled on version $ver"
      exit
    fi
  fi
fi

# remove any existing database
CMD="rm -rf hpctoolkit-amg2013.d"
echo $CMD
$CMD

# compute program structure information for the amg2013 binary
CMD="hpcstruct ${OUT}.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
echo ${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_ANALYZE_CMD}
${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_ANALYZE_CMD}
