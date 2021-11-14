#!/bin/bash

$HPCTOOLKIT_LULESH_OMP_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=lulesh2.0
EXEC=LULESH/openacc/src/${BINARY}
OUT=hpctoolkit-${BINARY}-acc-pc

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

# measure an execution of lulesh-acc
CMD="time ${HPCTOOLKIT_LULESH_ACC_LAUNCH} hpcrun -o $OUT.m -e gpu=nvidia,pc ${EXEC} -i 10"
echo $CMD
$CMD

# compute program structure information for the lulesh-acc cpu and gpu binaries
CMD="hpcstruct --gpucfg yes $OUT.m" 
echo $CMD "(note: no \"-j <n>\" for parallel analysis since the cubin is not large)"
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-pc.done
