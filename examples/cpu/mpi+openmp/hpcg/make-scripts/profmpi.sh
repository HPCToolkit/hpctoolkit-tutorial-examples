BINARY=xhpcg
EXEC=build/bin/${BINARY}
OUT=hpctoolkit-${BINARY}

# remove any existing database
/bin/rm -rf ${OUT}.d

# analyze the program structure and combine it with the measurement data 
echo analyzing xhpcg measurement data by running \'${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_ANALYZE_CMD}\'
${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_ANALYZE_CMD}
