#!/bin/bash

$HPCTOOLKIT_LULESH_OMP_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=lulesh2.0
EXEC=LULESH/omp_4.0/${BINARY}
OUT=hpctoolkit-${BINARY}-omp-pc

CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

$HPCTOOLKIT_BEFORE_RUN_PC

# measure an execution of lulesh-omp
CMD="time ${HPCTOOLKIT_LULESH_OMP_LAUNCH} ${HPCTOOLKIT_LULESH_OMP_LAUNCH_ARGS} hpcrun -o $OUT.m -e gpu=nvidia,pc ${EXEC} -i 100"
echo $CMD
eval $CMD

$HPCTOOLKIT_AFTER_RUN_PC

# compute program structure information for lulesh-omp cpu and gpu binaries 
CMD="hpcstruct --gpucfg yes $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-pc.done
