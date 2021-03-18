BINARY=PeleC3d.gnu.CUDA.ex
DIR=PeleC/Exec/RegTests/PMF
EXEC=./${BINARY}
INPUT=./inputs_ex
OUT=hpctoolkit-${BINARY}-gpu-cuda-pc

if [[ -z "`type -p hpcrun`" ]] 
then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
fi

cd ${DIR}

/bin/rm -rf ${OUT}.m ${OUT}.d
# measure an execution of PeleC
RUN="time ${QS_LAUNCHER} hpcrun -o $OUT.m -e gpu=nvidia,pc ${EXEC} ${INPUT}"
echo ${RUN} ...
${RUN}

# compute program structure information for the PeleC binary
STRUCT_QS="hpcstruct -j 16 ${EXEC}"
echo ${STRUCT_QS} ... 
$STRUCT_QS

# compute program structure information for the PeleC cubins
STRUCT_CUBIN="hpcstruct -j 16 --gpucfg no $OUT.m" 
echo ${STRUCT_CUBIN} ... 
${STRUCT_CUBIN}

# combine the measurements with the program structure information
ANALYZE="hpcprof -S ${BINARY}.hpcstruct -o $OUT.d $OUT.m"
echo $ANALYZE ...
${ANALYZE}

cd -

mv ${DIR}/$OUT.d ${DIR}/$OUT.m ./
