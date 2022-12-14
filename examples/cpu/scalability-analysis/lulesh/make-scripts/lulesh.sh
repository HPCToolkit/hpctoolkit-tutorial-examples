DIR=lulesh
OUT=hpctoolkit-lulesh

/bin/rm -rf ${OUT}-16.m ${OUT}-32.m log.run.* 

# measure executions of lulesh with 8 thread and 16 threads to compare them
echo executing lulesh on 16 and 32 threads by running \'${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_RUN_CMD}\'
${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_RUN_CMD}
