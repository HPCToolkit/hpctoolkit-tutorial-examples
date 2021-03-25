BINARY=amg2013
EXEC=AMG2013/test/${BINARY}

if [[ -z "`type -p hpcprof-mpi`" ]] 
then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
fi

# remove any existing database
/bin/rm -rf hpctoolkit-amg2013.d

# compute program structure information for the amg2013 binary
STRUCT_BIN="hpcstruct -j 8 ${EXEC}"
echo ${STRUCT_BIN} ... 
${STRUCT_BIN}

# combine the measurements with the program structure information
echo ${ANALYZE_CMD} ...
${ANALYZE_CMD}
