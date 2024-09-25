#!/bin/bash

BINARY=lmp
LAMMPS_DIR=lammps/lammps/build
EXEC=${LAMMPS_DIR}/$BINARY
OUT=hpctoolkit-$BINARY

echo rm -rf log.run.done log.lammps $OUT.m $OUT.d
rm -rf log.run.done log.lammps $OUT.m $OUT.d

$HPCTOOLKIT_LAMMPS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_LAMMPS_ROOT"

# measure an execution of lammps
export OMP_NUM_THREADS=$HPCTOOLKIT_LAMMPS_OMP_NUM_THREADS
CMD="time ${HPCTOOLKIT_LAMMPS_LAUNCH} hpcrun -o $OUT.m -e CPUTIME -e gpu=${HPCTOOLKIT_GPU_PLATFORM} -tt $EXEC -k on g 1 -sf kk -in lammps/lammps/src/INTEL/TEST/in.intel.lj"
echo $CMD
$CMD

# compute program structure information for the lammps cpu and gpu binaries
unset OMP_NUM_THREADS
CMD="time hpcstruct --gpucfg no $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run.done
