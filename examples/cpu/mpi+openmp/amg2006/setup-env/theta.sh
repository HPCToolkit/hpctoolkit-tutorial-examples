export MPI_CC=cc
export RUN_CMD="qsub -A ATPESC2020 -q ATPESC2020 -t 12 -n 4 job-scripts/run-amg-cray"
export ANALYZE_CMD="qsub -A ATPESC2020 -q ATPESC2020 -t 10 -n 2 job-scripts/run-profmpi-cray"
export CLEAN_CMD="/bin/rm -rf *.output *.error *.cobaltlog"

