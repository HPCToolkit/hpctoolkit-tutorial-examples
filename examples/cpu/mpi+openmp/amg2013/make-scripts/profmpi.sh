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
STRUCT_BIN="hpcstruct hpctoolkit-amg2013.m"
echo ${STRUCT_BIN} ... 
${STRUCT_BIN}

echo analyzing amg2013 measurement data by running \'${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_ANALYZE_CMD}\'
${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_ANALYZE_CMD}
