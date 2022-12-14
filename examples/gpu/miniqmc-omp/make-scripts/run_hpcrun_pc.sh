#!/bin/bash

$HPCTOOLKIT_MINIQMC_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=miniqmc
EXEC=miniqmc/miniqmc-build/bin/${BINARY}
OUT=hpctoolkit-${BINARY}-gpu-openmp-pc

# remove old data
CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

$HPCTOOLKIT_BEFORE_RUN_PC

# measure an execution of miniqmc
RUN="time ${HPCTOOLKIT_MINIQMC_LAUNCH} hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia,pc -t ${EXEC}"
echo OMP_NUM_THREADS=10 ${RUN} -g '\"2 2 1\"' 
OMP_NUM_THREADS=10 ${RUN} -g '\"2 2 1\"'

$HPCTOOLKIT_AFTER_RUN_PC

# compute program structure information for the miniqmc cpu and gpu binaries recorded during execution
CMD="hpcstruct --gpucfg yes $OUT.m"
echo $CMD 
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD
