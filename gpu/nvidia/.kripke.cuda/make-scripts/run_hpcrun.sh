#!/bin/bash

BINARY=kripke.exe
KRIPKE_DIR=Kripke$QA_TEST_VARIANT/Kripke/build/
EXEC=${KRIPKE_DIR}/$BINARY
OUT=kripke-md$QA_TEST_VARIANT

echo rm -rf log.kripke $OUT.m $OUT.d
rm -rf log.kripke $OUT.m $OUT.d

$HPCTOOLKIT_KRIPKE_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_KRIPKE_ROOT"

# measure an execution of kripke
export OMP_NUM_THREADS=$HPCTOOLKIT_KRIPKE_OMP_NUM_THREADS
CMD="time ${HPCTOOLKIT_KRIPKE_LAUNCH} hpcrun -o $OUT.m -e CPUTIME -e gpu=${HPCTOOLKIT_GPU_PLATFORM} -t $EXEC"
echo $CMD
$CMD

# compute program structure information for the kripke cpu and gpu binaries
unset OMP_NUM_THREADS
CMD="time hpcstruct --gpucfg no $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD
