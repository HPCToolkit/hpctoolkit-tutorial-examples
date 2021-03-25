export CUPTI_DEVICE_NUM=1
export CUPTI_SAMPLING_PERIOD=5

PC_SAMPLING_DIR=build/cupti_test/cupti-preload/pc_sampling
LAGHOS_DIR=build/Laghos
EXEC=${LAGHOS_DIR}/laghos
OUT=hpctoolkit-laghos-pc

# link the executable in this directory for convenience
rm -f laghos
ln -s $EXEC

# measure an execution of laghos
echo "${HPCTOOLKIT_LAUNCHER_SINGLE_GPU} hpcrun -o $OUT.m -e gpu=nvidia,pc ${LAGHOS_DIR}/laghos -p 0 -dim 2 -rs 1 -tf 0.05 -pa -d cuda"
time ${HPCTOOLKIT_LAUNCHER_SINGLE_GPU} hpcrun -o $OUT.m -e gpu=nvidia,pc ${LAGHOS_DIR}/laghos -p 0 -dim 2 -rs 1 -tf 0.05 -pa -d cuda

# compute program structure information for the laghos binary
echo hpcstruct -j 16 laghos ...
hpcstruct -j 16 laghos

# compute program structure information for the laghos cubins
echo hpcstruct -j 16 $OUT.m ...
hpcstruct -j 16 $OUT.m

# combine the measurements with the program structure information
echo hpcprof -S laghos.hpcstruct -o $OUT.d $OUT.m
hpcprof -S laghos.hpcstruct -o $OUT.d $OUT.m