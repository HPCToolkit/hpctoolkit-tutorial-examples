LAMMPS_DIR=build/lammps/build
EXEC=${LAMMPS_DIR}/lmp
OUT=hpctoolkit-lmp-pc

# link the executable in this directory for convenience
rm -f lmp
ln -s $EXEC

# measure an execution of laghos
export OMP_NUM_THREADS=2
echo "time ${HPCTOOLKIT_LAUNCHER} hpcrun -t -o $OUT.m -e gpu=nvidia,pc ./lmp -k on g 1 -sf kk -in build/lammps/bench/in.lj"
time ${HPCTOOLKIT_LAUNCHER} hpcrun -t -o $OUT.m -e gpu=nvidia,pc ./lmp -k on g 1 -sf kk -in build/lammps/bench/in.lj

# compute program structure information for the lammps binary
echo hpcstruct -j 16 lmp ...
time hpcstruct -j 16 lmp

# compute program structure information for the laghos cubins
echo hpcstruct -j 16 $OUT.m ...
time hpcstruct -j 16 $OUT.m

# combine the measurements with the program structure information
echo hpcprof -S lmp.hpcstruct -o $OUT.d $OUT.m
time hpcprof -S lmp.hpcstruct -o $OUT.d $OUT.m
