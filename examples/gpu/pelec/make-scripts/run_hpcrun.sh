#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD
$HPCTOOLKIT_MODULES_USE
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_PELEC_ROOT"

BINARY=PeleC-TG
LOC=Exec/RegTests/TG
DIR=../PeleC/build/${LOC}
EXEC=${DIR}/${BINARY}
INPUT=../PeleC/${LOC}/tg-1.inp max_step=1000
OUT=hpctoolkit-${BINARY}-gpu-${HPCTOOLKIT_PELEC_GPU_PLATFORM}

CMD="rm -rf ${OUT}.m ${OUT}.d dir.run"
echo $CMD
$CMD

mkdir dir.run
cd dir.run

# remove old data
CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

# measure an execution of PeleC
CMD="time ${HPCTOOLKIT_PELEC_LAUNCH} ${HPCTOOLKIT_PELEC_LAUNCH_ARGS} hpcrun -o $OUT.m -e REALTIME -e gpu=${HPCTOOLKIT_GPU_PLATFORM} -t ${EXEC} ${INPUT}"
echo $CMD
eval $CMD

# compute program structure information
CMD="hpcstruct --gpucfg no $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof --only-exe ${BINARY} -o $OUT.d $OUT.m"
echo $CMD
$CMD

mv $OUT.d $OUT.m ..
cd ..
touch log.run.done
