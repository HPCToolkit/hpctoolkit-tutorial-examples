BINARY=amg2006
DIR=AMG2006/test
EXEC=${DIR}/${BINARY}
INPUT=sstruct.in.AMG.FD 

OUT=hpctoolkit-amg2006

if [[ -z "`type -p hpcrun`" ]] 
then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
fi

rm -f ${INPUT} 
ln -s  ${DIR}/${INPUT}

/bin/rm -rf ${OUT}.m 
# measure an execution of amg2006
echo ${RUN_CMD}
${RUN_CMD}
