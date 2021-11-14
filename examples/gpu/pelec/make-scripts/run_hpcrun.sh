#!/bin/bash

$HPCTOOLKIT_PELEC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=PeleC-TG
LOC=Exec/RegTests/TG
DIR=../PeleC/build/${LOC}
EXEC=${DIR}/${BINARY}
INPUT=../PeleC/${LOC}/tg-1.inp max_step=1000
OUT=hpctoolkit-${BINARY}-gpu-cuda

CMD="rm -rf ${OUT}.m ${OUT}.d dir.run"
echo $CMD
$CMD

mkdir dir.run
cd dir.run

# measure an execution of PeleC
if [[ "${HPCTOOLKIT_TUTORIAL_GPU_PLATFORM}" == "summit" ]]
then
  echo "${HPCTOOLKIT_PELEC_LAUNCH} --smpiargs=\"-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks\" \
    hpcrun -o $OUT.m -e CPUTIME -e gpu=nvidia -t ${EXEC} ${INPUT}" 
  ${HPCTOOLKIT_PELEC_LAUNCH} --smpiargs="-x PAMI_DISABLE_CUDA_HOOK=1 -disable_gpu_hooks" \
    hpcrun -o $OUT.m -e CPUTIME -e gpu=nvidia -t ${EXEC} ${INPUT}
else
  echo "${HPCTOOLKIT_PELEC_LAUNCH} hpcrun -o $OUT.m -e CPUTIME -e gpu=nvidia -t ${EXEC} ${INPUT}"
  time  ${HPCTOOLKIT_PELEC_LAUNCH} hpcrun -o $OUT.m -e CPUTIME -e gpu=nvidia -t ${EXEC} ${INPUT}
fi


# compute program structure information for the PeleC cpu and gpu binaries
CMD="hpcstruct --gpucfg no $OUT.m" 
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

mv $OUT.d $OUT.m ..
cd ..
touch log.run.done
