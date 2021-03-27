#!/bin/bash 

BINARY=lmp
LAMMPS_DIR=lammps/lammps/build
EXEC=${LAMMPS_DIR}/$BINARY
OUT=hpctoolkit-$BINARY

STRUCT_FILE=$BINARY.hpcstruct

echo rm -rf log.run.done log.lammps $STRUCT_FILE $OUT.m $OUT.d
rm -rf log.run.done log.lammps $STRUCT_FILE $OUT.m $OUT.d

$HPCTOOLKIT_LAMMPS_MODULES_BUILD
$HPCTOOLKIT_LAMMPS_MODULES_HPCTOOLKIT

# measure an execution of laghos
export OMP_NUM_THREADS=2
CMD="time ${HPCTOOLKIT_LAUNCHER} hpcrun -o $OUT.m -e cycles -e gpu=nvidia -t $EXEC -k on g 1 -sf kk -in lammps/lammps/src/USER-INTEL/TEST/in.intel.lj"
echo ${CMD}
$CMD

# compute program structure information for the lammps binary
SCMD="time hpcstruct -j 16 -o $STRUCT_FILE $EXEC"
echo $SCMD
$SCMD

# compute program structure information for the laghos cubins
echo hpcstruct -j 16 $OUT.m ...
time hpcstruct -j 16 $OUT.m

# combine the measurements with the program structure information
echo hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m
time hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m

touch log.run.done
