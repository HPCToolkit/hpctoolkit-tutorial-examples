#!/bin/bash 

$HPCTOOLKIT_ARBORX_MODULES_BUILD
$HPCTOOLKIT_MODULES_USE
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_ARBORX_ROOT"

BINARY=ArborX_Example_MolecularDynamics.exe
EXEC=ArborX/arborx-cuda/examples/molecular_dynamics/${BINARY}
OUT=hpctoolkit-arborx-md

CMD="rm -rf ${OUT}.m ${OUT}.d"
echo $CMD
$CMD

# measure an execution of ArborX_Example_MolecularDynamics.exe
CMD="time ${HPCTOOLKIT_ARBORX_LAUNCH} ${HPCTOOLKIT_ARBORX_LAUNCH_ARGS} hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia -tt ${EXEC}"
echo $CMD
eval $CMD

# compute program structure information for ArborX_Example_MolecularDynamics.exe CPU and GPU binaries
CMD="time hpcstruct --gpucfg no $OUT.m" 
echo $CMD
$CMD

# combine measurement data with program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run.done
