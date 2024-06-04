DIR=AMG2013/test
INPUT=sstruct.in.MG.FD 
OUT=hpctoolkit-amg2013

rm -f ${INPUT} 
echo `pwd`
ln -s ${DIR}/${INPUT}

/bin/rm -rf ${OUT}.m log.run.* 

# measure an execution of amg2013
echo executing amg2013 by running \'${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_RUN_CMD}\'
${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_RUN_CMD}
