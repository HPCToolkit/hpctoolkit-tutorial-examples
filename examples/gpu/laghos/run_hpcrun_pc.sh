export CUPTI_DEVICE_NUM=1
export CUPTI_SAMPLING_PERIOD=5

PC_SAMPLING_DIR=build/cupti_test/cupti-preload/pc_sampling
LAGHOS_DIR=build/Laghos/cuda
EXEC=${LAGHOS_DIR}/laghos
OUT=hpctoolkit-laghos-pc

# link the executable in this directory for convenience
rm -f laghos
ln -s $EXEC

# measure an execution of laghos
time mpirun -np 4 hpcrun -o $OUT.m -e cycles -e gpu=nvidia,pc -t ${LAGHOS_DIR}/laghos -p 0 -m ${LAGHOS_DIR}/../data/square01_quad.mesh -rs 1 -tf 0.05 -pa

# compute program structure information for the laghos binary
echo hpcstruct -j 16 laghos ...
hpcstruct -j 16 laghos

# compute program structure information for the laghos cubins
echo hpcstruct -j 16 $OUT.m ...
hpcstruct -j 16 --gpucfg yes $OUT.m

# combine the measurements with the program structure information
echo mpirun -n 4  hpcprof-mpi -S laghos.hpcstruct -o $OUT.d $OUT.m
mpirun -n 4  hpcprof-mpi -S laghos.hpcstruct -o $OUT.d $OUT.m
