export MPI_CC=mpicc
export RUN_CMD="qsub -A ATPESC2020 -q training -t 12 -n 4 job-scripts/run-amg-cooley"
export ANALYZE_CMD="qsub -A ATPESC2020 -q training -t 10 -n 2 job-scripts/run-profmpi-cooley"
export CLEAN_CMD="/bin/rm -rf *.output *.error *.cobaltlog"

