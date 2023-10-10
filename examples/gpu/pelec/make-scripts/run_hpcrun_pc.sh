#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD
$HPCTOOLKIT_MODULES_USE
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_PELEC_ROOT"

BINARY=PeleC-TG
LOC=Exec/RegTests/TG
DIR=../PeleC/build/${LOC}
EXEC=${DIR}/${BINARY}
INPUT=../PeleC/${LOC}/tg-1.inp max_step=100
OUT=hpctoolkit-${BINARY}-gpu-cuda-pc

CMD="rm -rf ${OUT}.m ${OUT}.d dir.run-pc"
echo $CMD
$CMD

mkdir dir.run-pc
cd dir.run-pc

# remove old data
CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

$HPCTOOLKIT_BEFORE_RUN_PC

# measure an execution of PeleC
CMD="time ${HPCTOOLKIT_PELEC_LAUNCH} ${HPCTOOLKIT_PELEC_LAUNCH_ARGS} hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}"
echo $CMD
eval $CMD

$HPCTOOLKIT_AFTER_RUN_PC

# compute program structure information
CMD="hpcstruct --gpucfg yes $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof --only-exe ${BINARY} -o $OUT.d $OUT.m"
echo $CMD
$CMD

mv $OUT.d $OUT.m .. 
cd ..
touch log.run-pc.done
