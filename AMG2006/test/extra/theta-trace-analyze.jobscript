#!/bin/sh
#COBALT -A EarlyPerf_theta
#COBALT -t 20
#COBALT -n 16

JID=114615

ranks=32

HPCT=/projects/Tools/hpctoolkit/pkgs-theta/hpctoolkit/bin

echo ; echo "start:  `date`" ; echo
 
aprun -n $ranks  -N 16  --cc none  \
    ${HPCT}/hpcprof-mpi   \
        -S  amg2006.hpcstruct  \
        -I  `pwd`/../+  \
        hpctoolkit-amg2006-measurements-${JID}

echo ; echo "end:  `date`" ; echo

