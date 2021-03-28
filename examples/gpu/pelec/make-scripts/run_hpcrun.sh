#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=PeleC3d.gnu.CUDA.ex
DIR=PeleC/Exec/RegTests/PMF
EXEC=./${BINARY}
INPUT=./inputs_ex
OUT=hpctoolkit-${BINARY}-gpu-cuda
STRUCT_PELEC="hpcstruct -j 16 ${EXEC}"

cd ${DIR}

CMD="rm -rf ${OUT}.m ${OUT}.d $STRUCT_FILE"
echo $CMD
$CMD

# measure an execution of PeleC
if [[ "${HPCTOOLKIT_TUTORIAL_GPU_PLATFORM}" == "summit" ]]
then
  echo "${HPCTOOLKIT_PELEC_LAUNCH} --smpiargs=\"-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks\" \
    hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia -t ${EXEC} ${INPUT}" 
  ${HPCTOOLKIT_PELEC_LAUNCH} --smpiargs="-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks" \
    hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia -t ${EXEC} ${INPUT}
else
  echo "${HPCTOOLKIT_PELEC_LAUNCH} hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia -t ${EXEC} ${INPUT}"
  time  ${HPCTOOLKIT_PELEC_LAUNCH} hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia -t ${EXEC} ${INPUT}
fi


# compute program structure information for the PeleC binary
echo ${STRUCT_PELEC}
$STRUCT_PELEC

# compute program structure information for the PeleC cubins
CMD="hpcstruct -j 16 --gpucfg no $OUT.m" 
echo $$CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -S ${BINARY}.hpcstruct -o $OUT.d $OUT.m"
echo $CMD
$CMD

cd -

mv ${DIR}/$OUT.d ${DIR}/$OUT.m ./
