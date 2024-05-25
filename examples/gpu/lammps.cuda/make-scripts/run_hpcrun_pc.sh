#!/bin/bash 

BINARY=lmp
LAMMPS_DIR=lammps/lammps/build
EXEC=${LAMMPS_DIR}/$BINARY
OUT=hpctoolkit-$BINARY-pc

# remove old files and directories
CMD="rm -rf log.run-pc.done log.lammps $OUT.m $OUT.d"
echo $CMD
$CMD

# load up modules
$HPCTOOLKIT_LAMMPS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT
cd "$HPCTOOLKIT_LAMMPS_ROOT"

$HPCTOOLKIT_BEFORE_RUN_PC

# measure an execution of lammps
export OMP_NUM_THREADS=2
CMD="time ${HPCTOOLKIT_LAMMPS_LAUNCH} hpcrun -o $OUT.m -e gpu=nvidia,pc $EXEC -k on g 1 -sf kk -in lammps/lammps/bench/in.lj"
echo $CMD
$CMD

$HPCTOOLKIT_AFTER_RUN_PC

# compute program structure information for the lammps cpu and gpu binaries
CMD="time hpcstruct --gpucfg yes $OUT.m"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="time hpcprof -o $OUT.d $OUT.m"
echo $CMD
$CMD

touch log.run-pc.done
