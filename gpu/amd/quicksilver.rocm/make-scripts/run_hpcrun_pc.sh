#!/bin/bash

$HPCTOOLKIT_QS_MODULES_BUILD
$HPCTOOLKIT_MODULES_USE
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_QS_ROOT"

BINARY=qs
EXEC=quicksilver$QA_TEST_VARIANT/quicksilver/src/${BINARY}
OUT=hpctoolkit-${BINARY}${QA_TEST_VARIANT}-pc

CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

$HPCTOOLKIT_BEFORE_RUN_PC

# measure an execution of quicksilver
CMD="time ${HPCTOOLKIT_QS_LAUNCH} ${HPCTOOLKIT_QS_LAUNCH_ARGS} hpcrun -o $OUT.m -e gpu=rocm ${EXEC}"
echo $CMD
eval $CMD

$HPCTOOLKIT_AFTER_RUN_PC

# compute program structure information for quicksilver CPU and GPU binaries
CMD="time hpcstruct --gpucfg yes $OUT.m" 
echo $CMD
$CMD

# combine measurement data with program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-pc.done
