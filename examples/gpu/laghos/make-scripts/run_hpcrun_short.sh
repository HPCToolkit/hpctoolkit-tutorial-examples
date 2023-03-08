#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

export CUPTI_DEVICE_NUM=1
export CUPTI_SAMPLING_PERIOD=5

BINARY=laghos
LAGHOS_DIR=laghos/Laghos
EXEC=${LAGHOS_DIR}/$BINARY
OUT=hpctoolkit-laghos-short

CMD="rm -rf $OUT.m $OUT.d"
echo $CMD
$CMD

# measure an execution of laghos
CMD="time ${HPCTOOLKIT_LAGHOS_LAUNCH} ${HPCTOOLKIT_LAGHOS_LAUNCH_ARGS} hpcrun -o $OUT.m -e CPUTIME -e gpu=nvidia -t $EXEC -p 0 -dim 2 -rs 1 -tf 0.75 -pa -d cuda"
echo $CMD
eval $CMD

# compute program structure information for laghos cpu and gpu binaries
CMD="hpcstruct $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-short.done
