#!/bin/bash

BINARY=ArborX_Example_MolecularDynamics.exe
ARBORX_DIR=ArborX$QA_TEST_VARIANT/ArborX/build/examples/molecular_dynamics/
EXEC=${ARBORX_DIR}/$BINARY
OUT=arborx-md$QA_TEST_VARIANT

echo rm -rf log.run.done log.arborx $OUT.m $OUT.d
rm -rf log.run.done log.arborx $OUT.m $OUT.d

$HPCTOOLKIT_ARBORX_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_ARBORX_ROOT"

# measure an execution of arborx
export OMP_NUM_THREADS=$HPCTOOLKIT_ARBORX_OMP_NUM_THREADS
CMD="time ${HPCTOOLKIT_ARBORX_LAUNCH} hpcrun -o $OUT.m -e CPUTIME -e gpu=${HPCTOOLKIT_GPU_PLATFORM} -t $EXEC"
echo $CMD
$CMD

# compute program structure information for the arborx cpu and gpu binaries
unset OMP_NUM_THREADS
CMD="time hpcstruct --gpucfg no $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

# touch log.run.done
