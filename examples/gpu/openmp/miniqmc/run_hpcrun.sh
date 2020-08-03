BINARY=miniqmc
EXEC=miniqmc/miniqmc-build/bin/${BINARY}

OUT=hpctoolkit-miniqmc-gpu

if [[ -z "`type -p hpcrun`" ]] 
then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
fi


/bin/rm -rf ${OUT}.m ${OUT}.d


# measure an execution of miniqmc
RUN="time hpcrun -o $OUT.m -e REALTIME -e gpu=nvidia -t ${EXEC}"
echo OMP_NUM_THREADS=10 ${RUN} -g '\"2 2 1\"' ...


OMP_NUM_THREADS=10 ${RUN} -g '\"2 2 1\"'

# compute program structure information for the miniqmc binary
STRUCT_MINI="hpcstruct -j 8 ${EXEC}"
echo ${STRUCT_MINI} ... 
$STRUCT_MINI

# compute program structure information for the miniqmc cuda binaries recorded during execution
STRUCT_CUBIN="hpcstruct -j 8 $OUT.m"
echo ${STRUCT_CUBIN} ... 
$STRUCT_CUBIN

# combine the measurements with the program structure information
ANALYZE="hpcprof -S ${BINARY}.hpcstruct -o $OUT.d $OUT.m"
echo $ANALYZE ...
${ANALYZE}
