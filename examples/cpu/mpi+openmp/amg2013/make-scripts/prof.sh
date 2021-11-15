BINARY=amg2013
EXEC=AMG2013/test/${BINARY}
OUT=hpctoolkit-amg2013

# compute program structure information for amg2013 and shared libraries
STRUCT_BIN="hpcstruct ${OUT}.m"
echo ${STRUCT_BIN} ... 
${STRUCT_BIN}

# remove any old results directory to avoid trouble 
rm -rf ${OUT}.d 

# combine the measurements with the program structure information
ANALYZE_CMD="hpcprof -o ${OUT}.d ${OUT}.m"
 
echo ${ANALYZE_CMD} ...
${ANALYZE_CMD}
