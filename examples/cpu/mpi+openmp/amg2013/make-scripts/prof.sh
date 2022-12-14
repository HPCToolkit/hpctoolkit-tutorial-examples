BINARY=amg2013
EXEC=AMG2013/test/${BINARY}
OUT=hpctoolkit-amg2013

if [[ -z "`type -p hpcprof`" ]] 
then
    echo hpctoolkit is not on your path. either load a module or add a hpctoolkit bin directory to your path manually.
    exit
fi

# compute program structure information for amg2013 and shared libraries
CMD="hpcstruct -j 8 hpctoolkit-amg2013.m"
echo $CMD 
$CMD

# remove any existing database
CMD="rm -rf ${OUT}.d"
echo $CMD
$CMD

# combine the measurements with the program structure information
CMD="hpcprof -o ${OUT}.d ${OUT}.m" 
echo $CMD
$CMD
