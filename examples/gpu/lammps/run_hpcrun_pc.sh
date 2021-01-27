LAMMPS_DIR=build/lammps/build
EXEC=${LAMMPS_DIR}/lmp
OUT=hpctoolkit-lmp-pc

# link the executable in this directory for convenience
rm -f lmp
ln -s $EXEC

# measure an execution of laghos
export OMP_NUM_THREADS=2
echo time mpirun -np 4 hpcrun -o $OUT.m -e cycles -e gpu=nvidia -t ./lmp -k on g 4 -sf kk -in build/lammps/src/USER-INTEL/TEST/in.intel.lj
time mpirun -np 4 hpcrun -o $OUT.m -e cycles -e gpu=nvidia,pc -t ./lmp -k on g 4 -sf kk -in build/lammps/src/USER-INTEL/TEST/in.intel.lj

# compute program structure information for the lammps binary
echo hpcstruct -j 16 lmp ...
time hpcstruct -j 16 lmp

# compute program structure information for the laghos cubins
echo hpcstruct -j 16 $OUT.m ...
time hpcstruct -j 16 $OUT.m

# combine the measurements with the program structure information
echo hpcprof -S lmp.hpcstruct -o $OUT.d $OUT.m
time hpcprof -S lmp.hpcstruct -o $OUT.d $OUT.m
