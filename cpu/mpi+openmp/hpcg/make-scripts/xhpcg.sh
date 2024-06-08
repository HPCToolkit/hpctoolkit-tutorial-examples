#!/bin/bash
EXEC=xhpcg
OUT=hpctoolkit-$EXEC

if [ "${HPCTOOLKIT_TUTORIAL_HPCG_READY}x" != "x" ]
then
    echo You must source 'setup-env/<machine>.sh' before you can launch a job
    exit
fi


/bin/rm -rf ${OUT}.m 
# measure an execution of xhpcg
echo executing $EXEC by running \'${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_RUN_CMD}\'
${HPCTOOLKIT_BATCH} ${HPCTOOLKIT_RUN_CMD}
