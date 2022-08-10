BINARY=amg2013
EXEC=AMG2013/test/${BINARY}

if [[ -z "`type -p hpcprof`" ]] 
then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
fi

# compute program structure information for the amg2013 binary
STRUCT_BIN="hpcstruct -j 8 hpctoolkit-amg2013.m"
echo ${STRUCT_BIN} ... 
${STRUCT_BIN}

# remove any old results directory to avoid trouble 
rm -rf hpctoolkit-amg2013.d

# combine the measurements with the program structure information
ANALYZE_CMD="hpcprof -o hpctoolkit-amg2013.d hpctoolkit-amg2013.m"
 
echo hpcprof ${ANALYZE_CMD} ...
${ANALYZE_CMD}
