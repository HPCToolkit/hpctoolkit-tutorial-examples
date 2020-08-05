BINARY=amg2006
EXEC=AMG2006/test/${BINARY}

if [[ -z "`type -p hpcprof`" ]] 
then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
fi

# compute program structure information for the amg2006 binary
STRUCT_BIN="hpcstruct -j 8 ${EXEC}"
echo ${STRUCT_BIN} ... 
${STRUCT_BIN}

# combine the measurements with the program structure information
ANALYZE_CMD="hpcprof -S ${BINARY}.hpcstruct -o hpctoolkit-amg2006.d hpctoolkit-amg2006.m"
 
echo hpcprof ${ANALYZE_CMD} ...
${ANALYZE_CMD}
