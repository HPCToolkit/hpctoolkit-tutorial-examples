#!/bin/bash
#SBATCH --qos=debug
#SBATCH --time=5
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --constraint=knl
#SBATCH -o log.run.out
#SBATCH -e log.run.stderr

#------------------------------------------------------------------------------
# use LLVM OpenMP Tools support
#------------------------------------------------------------------------------
module use /global/common/software/m1759/hpctoolkit-install/2021.03/modules
module load openmp/ompt

#    if you comment out the use of the module openmp/ompt (which adds the LLVM 
#    OpenMP runtime to your LD_LIBRARY_PATH and uses it instead of Intel's OpenMP 
#    runtime), you will need to uncomment the line below to set OMP_TOOL=disabled. 
#    Without turning off HPCToolkit's OMPT support, the application will encounter 
#    an assert in HPCToolkit because Intel's implementation of OMPT doesn't meet 
#    HPCToolkit's needs

# export OMP_TOOL=disabled
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

  module use /global/common/software/m3977/hpctoolkit/2021-11/modules
  module load hpctoolkit/2021.11-cpu

export OMP_PROC_BIND=true
export OMP_PLACES=threads

export OMP_WAIT_POLICY=active



bind=--cpu-bind=cores 

export OMP_NUM_THREADS=16

export HPCRUN_ARGS="-o hpctoolkit-lulesh-${OMP_NUM_THREADS}.m -e CPUTIME -t"

srun -n 1 $bind  \
    hpcrun ${HPCRUN_ARGS} lulesh/lulesh2.0

export OMP_NUM_THREADS=32

export HPCRUN_ARGS="-o hpctoolkit-lulesh-${OMP_NUM_THREADS}.m -e CPUTIME -t"

srun -n 1 $bind  \
    hpcrun ${HPCRUN_ARGS} lulesh/lulesh2.0

touch log.run.done
