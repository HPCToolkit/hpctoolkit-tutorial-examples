BINARY=xhpcg
EXEC=build/bin/${BINARY}
OUT=hpctoolkit-${BINARY}

# compute program structure information for the xhpcg binary and its libraries
STRUCT_BIN="hpcstruct ${OUT}.m"
echo ${STRUCT_BIN} ... 
${STRUCT_BIN}

# remove any existing database
/bin/rm -rf ${OUT}.d

# combine the measurements with the program structure information
ANALYZE_CMD="hpcprof -o ${OUT}.d  ${OUT}.m"  
 
echo ${ANALYZE_CMD} ...
${ANALYZE_CMD}
