#!/bin/bash 

BINARY=ArborX_Example_MolecularDynamics.exe
ARBORX_DIR=ArborX$QA_TEST_VARIANT/ArborX/build/examples/molecular_dynamics/
EXEC=${ARBORX_DIR}/$BINARY
OUT=arborx-md$QA_TEST_VARIANT-pc

# remove old files and directories
CMD="rm -rf log.arborx $OUT.m $OUT.d"
echo $CMD
$CMD

# load up modules
$HPCTOOLKIT_ARBORX_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_ARBORX_ROOT"

echo "on entry OMP_NUM_THREADS=$OMP_NUM_THREADS"
# measure an execution of arborx
export OMP_NUM_THREADS=$HPCTOOLKIT_ARBORX_OMP_NUM_THREADS
echo "before run-pc OMP_NUM_THREADS=$OMP_NUM_THREADS"
CMD="time ${HPCTOOLKIT_ARBORX_LAUNCH} hpcrun -o $OUT.m -e gpu=${HPCTOOLKIT_GPU_PLATFORM_PC} $EXEC"
echo $CMD
$CMD

# compute program structure information for the arborx cpu and gpu binaries
unset OMP_NUM_THREADS
echo "before hpcstruct OMP_NUM_THREADS=$OMP_NUM_THREADS"
CMD="time hpcstruct --gpucfg yes $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

# touch log.run-pc.done
