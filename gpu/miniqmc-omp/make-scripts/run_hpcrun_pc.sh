#!/bin/bash

$HPCTOOLKIT_MINIQMC_MODULES_BUILD
$HPCTOOLKIT_MODULES_USE
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_MINIQMC_ROOT"

BINARY=miniqmc
EXEC=miniqmc/miniqmc-build/bin/${BINARY}
OUT=hpctoolkit-${BINARY}-gpu-openmp-pc

# remove old data
CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

$HPCTOOLKIT_BEFORE_RUN_PC

# measure an execution of miniqmc
CMD="OMP_NUM_THREADS=10 time ${HPCTOOLKIT_MINIQMC_LAUNCH} ${HPCTOOLKIT_MINIQMC_LAUNCH_ARGS} hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia,pc ${EXEC} -g '\"2 2 1\"'"
echo $CMD
eval $CMD

$HPCTOOLKIT_AFTER_RUN_PC

# compute program structure information for the miniqmc cpu and gpu binaries recorded during execution
CMD="hpcstruct --gpucfg yes $OUT.m"
echo $CMD 
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD
