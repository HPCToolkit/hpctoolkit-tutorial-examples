EXEC=quicksilver/src/qs
OUT=hpctoolkit-qs

# link the executable in this directory for convenience
rm -f qs
ln -s $EXEC

/bin/rm -rf ${OUT}.m ${OUT}.d
# measure an execution of laghos
RUN="time hpcrun -o $OUT.m -e REALTIME  -e gpu=nvidia -t ${EXEC}"
echo ${RUN} ...
${RUN}

# compute program structure information for the laghos binary
STRUCT_QS="hpcstruct -j 16 qs"
echo ${STRUCT_QS} ... 
$STRUCT_QS

# compute program structure information for the quicksilver cubins
STRUCT_CUBIN="hpcstruct --gpucfg yes $OUT.m" 
echo ${STRUCT_CUBIN} ... "(note: no \"-j <n>\" for parallel analysis since the cubin is not large)"
${STRUCT_CUBIN}

# combine the measurements with the program structure information
ANALYZE="hpcprof -S qs.hpcstruct -o $OUT.d $OUT.m"
echo $ANALYZE ...
${ANALYZE}
