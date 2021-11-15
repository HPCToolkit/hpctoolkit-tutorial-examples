BINARY=amg2013
EXEC=AMG2013/test/${BINARY}
OUT=hpctoolkit-amg2013

# remove any existing database
/bin/rm -rf hpctoolkit-amg2013.d log.analyze-parallel.*

echo analyzing amg2013 measurement data by running \'${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_ANALYZE_CMD}\'
${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_ANALYZE_CMD}
