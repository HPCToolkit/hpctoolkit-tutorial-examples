#!/bin/bash

$HPCTOOLKIT_QS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=qs
EXEC=quicksilver/src/${BINARY}
OUT=hpctoolkit-${BINARY}-gpu-cuda-pc

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

# measure an execution of quicksilver
CMD="time ${HPCTOOLKIT_QS_LAUNCH} hpcrun -o $OUT.m -e gpu=nvidia,pc ${EXEC}"
echo $CMD
$CMD

# compute program structure information for the quicksilver cpu and gpu binaries
CMD="hpcstruct --gpucfg yes $OUT.m" 
echo $CMD "(note: no \"-j <n>\" for parallel analysis since the cubin is not large)"
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-pc.done
