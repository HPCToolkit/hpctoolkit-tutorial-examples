#!/bin/bash 

BINARY=kripke.exe
KRIPKE_DIR=Kripke$QA_TEST_VARIANT/Kripke/build/
EXEC=${KRIPKE_DIR}/$BINARY
OUT=kripke-md$QA_TEST_VARIANT-pc

# remove old files and directories
CMD="rm -rf log.kripke $OUT.m $OUT.d"
echo $CMD
$CMD

# load up modules
$HPCTOOLKIT_KRIPKE_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_KRIPKE_ROOT"

echo "on entry OMP_NUM_THREADS=$OMP_NUM_THREADS"
# measure an execution of kripke
export OMP_NUM_THREADS=$HPCTOOLKIT_KRIPKE_OMP_NUM_THREADS
echo "before run-pc OMP_NUM_THREADS=$OMP_NUM_THREADS"
CMD="time ${HPCTOOLKIT_KRIPKE_LAUNCH} hpcrun -o $OUT.m -e gpu=${HPCTOOLKIT_GPU_PLATFORM_PC} $EXEC"
echo $CMD
$CMD

# compute program structure information for the kripke cpu and gpu binaries
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
