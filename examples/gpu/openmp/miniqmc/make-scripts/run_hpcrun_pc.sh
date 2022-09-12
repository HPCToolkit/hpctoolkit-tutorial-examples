#!/bin/sh

BINARY=miniqmc
EXEC=miniqmc/miniqmc-build/bin/${BINARY}

OUT=hpctoolkit-miniqmc-gpu-openmp-pc

# remove old data
/bin/rm -rf ${OUT}.m ${OUT}.d

# measure an execution of miniqmc
RUN="time ${HPCTOOLKIT_MINIQMC_LAUNCH} hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia,pc -t ${EXEC}"
echo OMP_NUM_THREADS=10 ${RUN} -g '\"2 2 1\"' 
OMP_NUM_THREADS=10 ${RUN} -g '\"2 2 1\"'

# compute program structure information for the miniqmc cpu and gpu binaries recorded during execution
STRUCT_GPU="hpcstruct --gpucfg yes $OUT.m"
echo ${STRUCT_GPU} ... 
${STRUCT_GPU}

# combine the measurements with the program structure information
ANALYZE="hpcprof -o $OUT.d $OUT.m"
echo $ANALYZE ...
${ANALYZE}
