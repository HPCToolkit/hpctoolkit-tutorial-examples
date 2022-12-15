#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=PeleC-TG
LOC=Exec/RegTests/TG
DIR=../PeleC/build/${LOC}
EXEC=${DIR}/${BINARY}
INPUT=../PeleC/${LOC}/example.inp
OUT=hpctoolkit-${BINARY}-gpu-${HPCTOOLKIT_PELEC_GPU_PLATFORM}

CMD="rm -rf ${OUT}.m ${OUT}.d dir.run"
echo $CMD
$CMD

mkdir dir.run
cd dir.run

# measure an execution of PeleC
echo "${HPCTOOLKIT_PELEC_LAUNCH} ${HPCTOOLKIT_PELEC_LAUNCH_ARGS} hpcrun -o $OUT.m -e REALTIME -e gpu=${HPCTOOLKIT_GPU_PLATFORM} -t ${EXEC} ${INPUT}"
time  ${HPCTOOLKIT_PELEC_LAUNCH} ${HPCTOOLKIT_PELEC_LAUNCH_ARGS} hpcrun -o $OUT.m -e REALTIME -e gpu=${HPCTOOLKIT_GPU_PLATFORM} -t ${EXEC} ${INPUT}

# compute program structure information
CMD="hpcstruct -j 16 --gpucfg no $OUT.m" 
echo $$CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

mv $OUT.d $OUT.m ..
cd ..
touch log.run.done
