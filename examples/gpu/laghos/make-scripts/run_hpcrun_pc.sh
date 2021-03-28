#!/bin/bash

$HPCTOOLKIT_LAGHOS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

export CUPTI_DEVICE_NUM=1
export CUPTI_SAMPLING_PERIOD=5

BINARY=laghos
LAGHOS_DIR=laghos/Laghos
EXEC=${LAGHOS_DIR}/$BINARY
OUT=hpctoolkit-laghos-pc

# measure an execution of laghos
echo "${HPCTOOLKIT_LAGHOS_LAUNCH} hpcrun -t -o $OUT.m -e gpu=nvidia,pc ${LAGHOS_DIR}/laghos -p 0 -dim 2 -rs 1 -tf 0.05 -pa -d cuda"
time  ${HPCTOOLKIT_LAGHOS_LAUNCH} hpcrun -t -o $OUT.m -e gpu=nvidia,pc ${LAGHOS_DIR}/laghos -p 0 -dim 2 -rs 1 -tf 0.05 -pa -d cuda

# compute program structure information for the laghos binary
STRUCT_FILE=$BINARY-pc.hpcstruct
echo hpcstruct -j 16 -o $STRUCT_FILE $EXEC
hpcstruct -j 16 -o $STRUCT_FILE $EXEC

# compute program structure information for the laghos cubins
echo hpcstruct -j 16 $OUT.m
hpcstruct -j 16 $OUT.m

# combine the measurements with the program structure information
echo hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m
hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m
