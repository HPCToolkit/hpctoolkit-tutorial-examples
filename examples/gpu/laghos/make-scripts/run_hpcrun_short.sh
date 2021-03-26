#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD
$HPCTOOLKIT_LAGHOS_MODULES_HPCTOOLKIT

export CUPTI_DEVICE_NUM=1
export CUPTI_SAMPLING_PERIOD=5

BINARY=laghos
PC_SAMPLING_DIR=build/cupti_test/cupti-preload/pc_sampling
LAGHOS_DIR=build/Laghos
EXEC=${LAGHOS_DIR}/$BINARY
OUT=hpctoolkit-laghos-short

# measure an execution of laghos
echo "${HPCTOOLKIT_LAUNCHER_SINGLE_GPU} hpcrun -o $OUT.m -e cycles -e gpu=nvidia -t $EXEC -p 0 -dim 2 -rs 1 -tf 0.75 -pa -d cuda"
time ${HPCTOOLKIT_LAUNCHER_SINGLE_GPU} hpcrun -o $OUT.m -e cycles -e gpu=nvidia -t $EXEC -p 0 -dim 2 -rs 1 -tf 0.75 -pa -d cuda

# compute program structure information for the laghos binary
STRUCT_FILE=$BINARY-short
echo hpcstruct -j 16 -o $STRUCT_FILE $EXEC
hpcstruct -j 16 -o $STRUCT_FILE $EXEC

# compute program structure information for the laghos cubins
echo hpcstruct -j 16 $OUT.m
hpcstruct -j 16 $OUT.m

# combine the measurements with the program structure information
echo hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m
hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m
