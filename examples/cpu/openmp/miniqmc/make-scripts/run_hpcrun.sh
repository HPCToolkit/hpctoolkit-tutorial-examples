BINARY=miniqmc
EXEC=miniqmc/miniqmc-build/bin/${BINARY}

$HPCTOOLKIT_MINIQMC_BUILD_MODULES

OUT=hpctoolkit-miniqmc

if [[ -z "`type -p hpcrun`" ]] 
then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
fi


/bin/rm -rf ${OUT}.m ${OUT}.d
# measure an execution of miniqmc
RUN="time hpcrun -o $OUT.m -e REALTIME -t ${EXEC}"
echo ${RUN} ...
${RUN}

# compute program structure information for the miniqmc binary
STRUCT="hpcstruct -j 8 ${EXEC}"
echo ${STRUCT} ... 
${STRUCT}

# combine the measurements with the program structure information
ANALYZE="hpcprof -S ${BINARY}.hpcstruct -o $OUT.d $OUT.m"
echo $ANALYZE ...
${ANALYZE}
