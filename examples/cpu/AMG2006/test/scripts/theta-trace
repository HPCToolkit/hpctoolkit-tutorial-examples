#!/bin/sh

#------------------------------------------------------------------------------------
# a shell script to submit an hpcprof-mpi job to analyze a medium-sized performance 
# database on theta.
#------------------------------------------------------------------------------------
usage()
{
echo "usage: theta-trace <project>"
exit -1
}
if test -z "$1"; then
usage
fi

PROJ=$1

if ! test -f amg2006; then
  echo "the executable for amg2006 isn't in the current directory."
  echo "please create one by running the make in the directory above."
  echo "*** aborting measurement submission ***"
  exit -1
fi

cat <<EOF > $$.theta-trace.jobscript
#!/bin/sh
#COBALT -A ${PROJ}
#COBALT -t 20
#COBALT -n 16

DEPTH=64
RANKS=16
RANKS_PER_NODE=1

# export OMP_WAIT_POLICY=active
# export KMP_BLOCKTIME=infinite

EVENTS=REALTIME@1000,OMP_IDLE
ENVS="-e OMP_NUM_THREADS=32 -e HPCRUN_EVENT_LIST=\${EVENTS} -e HPCRUN_TRACE=1"
CPU_BINDING=none

EXEC=./amg2006
ARGS="-P 2 4 2   -r 8 8 8"

echo ; echo "start:  \`date\`" \; echo

aprun  -n \${RANKS} -N \${RANKS_PER_NODE} -d \${DEPTH} \${ENVS} -cc \${CPU_BINDING} \${EXEC} \${ARGS}

echo ; echo "end:  \`date\`" ; echo
EOF
chmod +x $$.theta-trace.jobscript
qsub $$.theta-trace.jobscript
