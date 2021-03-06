#!/bin/bash 

$HPCTOOLKIT_LULESH_OMP_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=lulesh2.0
EXEC=LULESH/omp_4.0/${BINARY}
OUT=hpctoolkit-${BINARY}-omp 
STRUCT_FILE=$BINARY.hpcstruct

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

# measure an execution of lulesh-omp
CMD="time ${HPCTOOLKIT_LULESH_OMP_LAUNCH} hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia -t ${EXEC} -i 1000"
echo $CMD
$CMD

# compute program structure information for the quicksilver binary
CMD="hpcstruct -j 16 -o $STRUCT_FILE ${EXEC}"
echo $CMD
$CMD

# compute program structure information for the quicksilver cubins
CMD="hpcstruct --gpucfg no $OUT.m" 
echo $CMD "(note: no \"-j <n>\" for parallel analysis since the cubin is not large)"
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run.done
