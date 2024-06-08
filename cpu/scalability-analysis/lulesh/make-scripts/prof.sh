BINARY=lulesh2.0
EXEC=lulesh/${BINARY}
OUT=hpctoolkit-lulesh

# compute program structure information for the 16 thread execution
STRUCT_BIN="hpcstruct ${OUT}-16.m"
echo ${STRUCT_BIN} ... 
${STRUCT_BIN}

# compute program structure information for the 32 thread execution
STRUCT_BIN="hpcstruct ${OUT}-32.m"
echo ${STRUCT_BIN} ... 
${STRUCT_BIN}

# remove any old results directory to avoid trouble 
rm -rf ${OUT}.d 

# combine the measurements with the program structure information
ANALYZE_CMD="hpcprof -o ${OUT}-16-to-32-scaling.d ${OUT}-16.m ${OUT}-32.m"
 
echo ${ANALYZE_CMD} ...
${ANALYZE_CMD}
