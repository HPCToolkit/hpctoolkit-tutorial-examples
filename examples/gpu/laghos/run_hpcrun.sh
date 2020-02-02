export CUPTI_DEVICE_NUM=1
export CUPTI_SAMPLING_PERIOD=5

PC_SAMPLING_DIR=build/cupti_test/cupti-preload/pc_sampling
LAGHOS_DIR=build/Laghos/cuda
EXEC=${LAGHOS_DIR}/laghos
OUT=hpctoolkit-laghos-measurements
rm -f laghos
ln -s $EXEC
time mpirun -np 4 hpcrun -o $OUT -e gpu=nvidia  -e REALTIME -t ${LAGHOS_DIR}/laghos -p 0 -m ${LAGHOS_DIR}/../data/square01_quad.mesh -rs 1 -tf 0.75 -pa
echo hpcstruct -j 16 laghos ...
hpcstruct -j 16 laghos
echo hpcstruct -j 16 $OUT ...
hpcstruct -j 16 $OUT
mpirun -n 4  hpcprof-mpi --metric-db no -S laghos.hpcstruct $OUT
