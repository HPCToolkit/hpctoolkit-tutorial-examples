#!/bin/bash
#SBATCH --qos=debug
#SBATCH --time=10
#SBATCH --nodes=1
#SBATCH --tasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --constraint=knl
#SBATCH -o log.analyze-parallel.out
#SBATCH -e log.analyze-parallel.stderr

BINARY=xhpcg
OUT=hpctoolkit-${BINARY}

module use /global/common/software/m3977/hpctoolkit/2021-11/modules
module load hpctoolkit/2021.11-cpu

hpcstruct ${OUT}.m

ranks=8

srun -n $ranks  --cpu-bind=cores \
    hpcprof-mpi --metric-db yes -o ${OUT}.d ${OUT}.m 

touch log.analyze-parallel.done
