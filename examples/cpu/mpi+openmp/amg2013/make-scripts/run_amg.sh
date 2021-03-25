DIR=AMG2013/test
INPUT=sstruct.in.MG.FD 

OUT=hpctoolkit-amg2013

if [ "${HPCTOOLKIT_TUTORIAL_AMG2013_READY}x" != "x" ]
then
    echo You must source 'setup-env/<machine>.sh' before you can launch a job
    exit
fi

rm -f ${INPUT} 
echo `pwd`
ln -s ${DIR}/${INPUT}

/bin/rm -rf ${OUT}.m 

# measure an execution of amg2013
echo executing amg2013 by running \'${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_RUN_CMD}\'
