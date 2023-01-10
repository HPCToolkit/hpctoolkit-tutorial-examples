#!/bin/bash 

$HPCTOOLKIT_LULESH_ACC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=lulesh2.0
EXEC=LULESH/openacc/src/${BINARY}
OUT=hpctoolkit-${BINARY}-acc 

CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

# measure an execution of lulesh openacc
CMD="time ${HPCTOOLKIT_LULESH_ACC_LAUNCH} ${HPCTOOLKIT_LULESH_ACC_LAUNCH_ARGS} hpcrun -o $OUT.m -e REALTIME -e gpu=${HPCTOOLKIT_GPU_PLATFORM} -t ${EXEC}"
echo $CMD
eval $CMD

# compute program structure information for the quicksilver cubins
CMD="hpcstruct --gpucfg no $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run.done
