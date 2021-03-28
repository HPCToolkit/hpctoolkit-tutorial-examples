#!/bin/bash 

$HPCTOOLKIT_LULESH_ACC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=lulesh2.0
EXEC=LULESH/openacc/src/${BINARY}
OUT=hpctoolkit-${BINARY}-acc 
STRUCT_FILE=$BINARY.hpcstruct

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

# measure an execution of lulesh openacc
CMD="time ${HPCTOOLKIT_LULESH_ACC_LAUNCH} hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia -t ${EXEC}"
echo $CMD
$CMD

# compute program structure information for the quicksilver binary
CMD="hpcstruct -j 16 -o $STRUCT_FILE ${EXEC}"
echo $CMD
$CMD

# compute program structure information for the quicksilver cubins
CMD="hpcstruct --gpucfg no $OUT.m" 
echo $CMD "(note: no '-j <n>' for parallel analysis since the cubin is not large)"
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run.done
