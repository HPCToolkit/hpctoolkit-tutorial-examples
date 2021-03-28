#!/bin/bash 

$HPCTOOLKIT_QS_MODULES_BUILD
$HPCTOOLKIT_MODULES_HPCTOOLKIT

BINARY=qs
EXEC=quicksilver/src/${BINARY}
OUT=hpctoolkit-${BINARY}-gpu-cuda

# remove output directories to avoid conflicts
/bin/rm -rf ${OUT}.m ${OUT}.d

# measure an execution of quicksilver
RUN="time ${HPCTOOLKIT_QS_LAUNCH} hpcrun -o $OUT.m -e REALTIME  -e gpu=nvidia -t ${EXEC}"
echo ${RUN}
${RUN}

# compute program structure information for the quicksilver binary
STRUCT_QS="hpcstruct -j 16 ${EXEC}"
echo ${STRUCT_QS}
$STRUCT_QS

# compute program structure information for the quicksilver cubins
STRUCT_CUBIN="hpcstruct --gpucfg no $OUT.m" 
echo ${STRUCT_CUBIN} "(note: no \"-j <n>\" for parallel analysis since the cubin is not large)"
${STRUCT_CUBIN}

# combine the measurements with the program structure information
ANALYZE="hpcprof -S ${BINARY}.hpcstruct -o $OUT.d $OUT.m"
echo $ANALYZE
${ANALYZE}

touch log.run.done
