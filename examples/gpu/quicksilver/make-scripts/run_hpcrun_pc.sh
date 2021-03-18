BINARY=qs
EXEC=quicksilver/src/${BINARY}
OUT=hpctoolkit-${BINARY}-gpu-cuda-pc

# link the executable in this directory for convenience
rm -f qs
ln -s $EXEC

/bin/rm -rf ${OUT}.m ${OUT}.d
# measure an execution of quicksilver
RUN="time ${HPCTOOLKIT_LAUNCHER} -n 1 -g 1 -a 1 hpcrun -o $OUT.m -e gpu=nvidia,pc ${EXEC}"
echo ${RUN} ...
${RUN}

# compute program structure information for the quicksilver binary
STRUCT_QS="hpcstruct -j 16 ${EXEC}"
echo ${STRUCT_QS} ... 
$STRUCT_QS

# compute program structure information for the quicksilver cubins
STRUCT_CUBIN="hpcstruct --gpucfg yes $OUT.m" 
echo ${STRUCT_CUBIN} ... "(note: no \"-j <n>\" for parallel analysis since the cubin is not large)"
${STRUCT_CUBIN}

# combine the measurements with the program structure information
ANALYZE="hpcprof -S ${BINARY}.hpcstruct -o $OUT.d $OUT.m"
echo $ANALYZE ...
${ANALYZE}
