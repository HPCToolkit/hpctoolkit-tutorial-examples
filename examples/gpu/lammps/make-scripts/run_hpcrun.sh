#!/bin/bash 

BINARY=lmp
LAMMPS_DIR=lammps/lammps/build
EXEC=${LAMMPS_DIR}/$BINARY
OUT=hpctoolkit-$BINARY

echo rm -rf log.run.done log.lammps $OUT.m $OUT.d
rm -rf log.run.done log.lammps $OUT.m $OUT.d

$HPCTOOLKIT_LAMMPS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

# measure an execution of lammps
export OMP_NUM_THREADS=2
CMD="time ${HPCTOOLKIT_LAMMPS_LAUNCH} hpcrun -o $OUT.m -e CPUTIME -e gpu=nvidia -t $EXEC -k on g 1 -sf kk -in lammps/lammps/src/INTEL/TEST/in.intel.lj"
echo $CMD
$CMD

# compute program structure information for the lammps cpu and gpu binaries
CMD="time hpcstruct $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run.done
