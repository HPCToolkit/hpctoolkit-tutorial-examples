#!/bin/bash 

$HPCTOOLKIT_LULESH_OMP_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=lulesh2.0
EXEC=LULESH/omp_4.0/${BINARY}
OUT=hpctoolkit-${BINARY}-omp 

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

# measure an execution of lulesh-omp
CMD="time ${HPCTOOLKIT_LULESH_OMP_LAUNCH} ${HPCTOOLKIT_LULESH_OMP_LAUNCH_ARGS} hpcrun -o $OUT.m -e CPUTIME -e gpu=${HPCTOOLKIT_GPU_PLATFORM} -t ${EXEC} -i 1000"
echo $CMD
eval $CMD

# compute program structure information for lulesh-omp cpu and gpu binaries
CMD="hpcstruct --gpucfg no $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run.done
