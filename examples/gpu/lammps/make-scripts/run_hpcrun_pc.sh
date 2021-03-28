#!/bin/bash 

BINARY=lmp
LAMMPS_DIR=lammps/lammps/build
EXEC=${LAMMPS_DIR}/$BINARY
OUT=hpctoolkit-$BINARY-pc

STRUCT_FILE=$BINARY-pc.hpcstruct

# remove old files and directories
RMCMD="rm -rf log.run-pc.done log.lammps $STRUCT_FILE $OUT.m $OUT.d"
echo $RMCMD
$RMCMD

# load up modules
$HPCTOOLKIT_LAMMPS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

# measure an execution of laghos
export OMP_NUM_THREADS=2
RUNCMD="time ${HPCTOOLKIT_LAMMPS_LAUNCH} hpcrun -t -o $OUT.m -e gpu=nvidia,pc $EXEC -k on g 1 -sf kk -in lammps/lammps/bench/in.lj"
echo $RUNCMD
$RUNCMD

# compute program structure information for the lammps binary
SCMD="time hpcstruct -j 16 -o $STRUCT_FILE $EXEC"
echo $SCMD
$SCMD

# compute program structure information for the laghos cubins
SCMD="time hpcstruct -j 16 --gpucfg yes $OUT.m"
echo $SCMD
$SCMD

# combine the measurements with the program structure information
PCMD="time hpcprof -S $STRUCT_FILE -o $OUT.d $OUT.m"
echo $PCMD
$PCMD

touch log.run-pc.done
