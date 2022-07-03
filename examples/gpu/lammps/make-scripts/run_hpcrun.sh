#!/bin/bash

BINARY=lmp
LAMMPS_DIR=lammps/lammps/build
EXEC=${LAMMPS_DIR}/$BINARY
OUT=hpctoolkit-$BINARY

STRUCT_FILE=$BINARY.hpcstruct

echo rm -rf log.run.done log.lammps $STRUCT_FILE $OUT.m $OUT.d
rm -rf log.run.done log.lammps $STRUCT_FILE $OUT.m $OUT.d

$HPCTOOLKIT_LAMMPS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

# measure an execution of laghos
export OMP_NUM_THREADS=2
CMD="time ${HPCTOOLKIT_LAMMPS_LAUNCH} hpcrun -o $OUT.m -e cycles -e gpu=nvidia -t $EXEC -k on g 1 -sf kk -in lammps/lammps/src/INTEL/TEST/in.intel.lj"
echo $CMD
$CMD

unset OMP_NUM_THREADS
# compute program structure information for the laghos cubins
CMD="time hpcstruct $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run.done
