#!/bin/bash

$HPCTOOLKIT_QS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=qs
EXEC=quicksilver/src/${BINARY}
OUT=hpctoolkit-${BINARY}-gpu-cuda-pc
STRUCT_FILE=${BINARY}-pc.hpcstruct

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

# measure an execution of quicksilver
CMD="time ${HPCTOOLKIT_QS_LAUNCH} hpcrun -t -o $OUT.m -e gpu=nvidia,pc ${EXEC}"
echo $CMD
$CMD

# compute program structure information for the quicksilver binary
CMD="hpcstruct -j 16 -o $STRUCT_FILE ${EXEC}"
echo $CMD
$CMD

# compute program structure information for the quicksilver cubins
CMD="hpcstruct --gpucfg yes $OUT.m" 
echo $CMD "(note: no \"-j <n>\" for parallel analysis since the cubin is not large)"
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-pc.done
