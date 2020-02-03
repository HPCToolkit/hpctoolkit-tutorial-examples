LAMMPS_DIR=build/lammps/build
EXEC=${LAMMPS_DIR}/lmp
OUT=hpctoolkit-lmp-measurements
rm -f lmp
ln -s $EXEC
time mpirun -np 4 hpcrun -o $OUT -e gpu=nvidia -e REALTIME -t ./lmp -k on g 4 -sf kk -in build/lammps/src/USER-INTEL/TEST/in.intel.lj
echo hpcstruct -j 16 lmp ...
hpcstruct -j 16 lmp
echo hpcstruct -j 16 $OUT ...
hpcstruct -j 16 $OUT
hpcprof -S lmp.hpcstruct $OUT
