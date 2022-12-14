#!/bin/bash

if [[ "${HPCTOOLKIT_GPU_PLATFORM}" != "nvidia" ]]; then
  echo "PC sampling is only supported on NVIDIA GPU platforms"
  exit 0
fi

$HPCTOOLKIT_PELEC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=PeleC3d.gnu.CUDA.ex
DIR=PeleC/Exec/RegTests/PMF
EXEC=./${BINARY}
INPUT=./inputs_ex
OUT=hpctoolkit-${BINARY}-gpu-cuda-pc

cd ${DIR}

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

# measure an execution of PeleC
echo "${HPCTOOLKIT_PELEC_LAUNCH} ${HPCTOOLKIT_PELEC_LAUNCH_ARGS" hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}"
time  ${HPCTOOLKIT_PELEC_LAUNCH} ${HPCTOOLKIT_PELEC_LAUNCH_ARGS" hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}

# measure an execution of PeleC
CMD="time ${HPCTOOLKIT_PELEC_LAUNCH} hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}"
echo $CMD
$CMD

# compute program structure information
CMD="hpcstruct -j 16 --gpucfg yes $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

cd -

mv ${DIR}/$OUT.d ${DIR}/$OUT.m ./
