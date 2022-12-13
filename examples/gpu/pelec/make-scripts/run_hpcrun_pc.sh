#!/bin/bash

if [[ "${HPCTOOLKIT_PELEC_GPU_PLATFORM}" != "cuda" ]]; then
  echo "PC sampling is not yet supported on GPU platforms other than NVIDIA"
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
if [[ "${HPCTOOLKIT_TUTORIAL_GPU_SYSTEM}" == "summit" ]]
then
  echo "${HPCTOOLKIT_PELEC_LAUNCH} --smpiargs=\"-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks\" \
    hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}"
  ${HPCTOOLKIT_PELEC_LAUNCH} --smpiargs="-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks" \
    hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}
else
  echo "${HPCTOOLKIT_PELEC_LAUNCH} hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}"
  time  ${HPCTOOLKIT_PELEC_LAUNCH} hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}
fi

# measure an execution of PeleC
CMD="time ${HPCTOOLKIT_PELEC_LAUNCH} hpcrun -o $OUT.m -e gpu=nvidia,pc -t ${EXEC} ${INPUT}"
echo $CMD
$CMD

# compute program structure information for the PeleC binary
STRUCT_OUT=${BINARY}-pc.hpcstruct
CMD="hpcstruct -j 16 -o ${STRUCT_OUT} ${EXEC}"
echo $CMD
$CMD

# compute program structure information for the PeleC cubins
CMD="hpcstruct -j 16 --gpucfg no $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -S ${STRUCT_OUT} -o $OUT.d $OUT.m"
echo $CMD
$CMD

cd -

mv ${DIR}/$OUT.d ${DIR}/$OUT.m ./
