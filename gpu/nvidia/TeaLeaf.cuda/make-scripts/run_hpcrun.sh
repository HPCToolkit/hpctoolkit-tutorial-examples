#!/bin/bash 

$HPCTOOLKIT_TEA_MODULES_BUILD
$HPCTOOLKIT_MODULES_USE
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd $HPCTOOLKIT_TEA_ROOT/TeaLeaf_CUDA

BINARY=tea_leaf
EDIR=bin
EXEC=${EDIR}/${BINARY}
OUT=hpctoolkit-${BINARY}${QA_TEST_VARIANT}

CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD


# measure an execution of quicksilver
CMD="time ${HPCTOOLKIT_TEA_LAUNCH} ${HPCTOOLKIT_TEA_LAUNCH_ARGS} hpcrun -o ../$OUT.m -e REALTIME -e gpu=nvidia -tt ${EXEC} ${EDIR}/tea.in"
echo $CMD
eval $CMD

# compute program structure information for quicksilver CPU and GPU binaries
CMD="time hpcstruct --gpucfg no ../$OUT.m" 
echo $CMD
$CMD

# combine measurement data with program structure information
CMD="time hpcprof -o ../$OUT.d ../$OUT.m"
echo $CMD
$CMD

touch ../log.run.done
