#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD
$HPCTOOLKIT_MODULES_USE
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=laghos
LAGHOS_DIR=laghos/Laghos
EXEC=${LAGHOS_DIR}/$BINARY
OUT=hpctoolkit-laghos-inst-count

CMD="rm -rf $OUT.m $OUT.d"
echo $CMD
$CMD

# measure an execution of laghos
CMD="time ${HPCTOOLKIT_LAGHOS_LAUNCH} ${HPCTOOLKIT_LAGHOS_LAUNCH_ARGS} hpcrun -o $OUT.m -e gpu=level0,inst=count -t ${LAGHOS_DIR}/laghos -p 0 -dim 2 -rs 1 -tf 0.05 -pa -d raja"
echo $CMD
eval $CMD

# compute program structure information for the laghos cpu and gpu binaries
CMD="hpcstruct yes $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-inst-count.done
