#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=PeleC3d.gnu.${HPCTOOLKIT_PELEC_GPU_PLATFORM^^}.ex
DIR=PeleC/Exec/RegTests/PMF
EXEC=./${BINARY}
INPUT=./inputs_ex
OUT=hpctoolkit-${BINARY}-gpu-${HPCTOOLKIT_PELEC_GPU_PLATFORM}

cd ${DIR}

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

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

cd -

mv ${DIR}/$OUT.d ${DIR}/$OUT.m ./
