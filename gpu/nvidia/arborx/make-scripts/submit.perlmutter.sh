#!/usr/bin/bash
#SBATCH -A ntrain9
#SBATCH -q debug
#SBATCH -N 1
#SBATCH -C gpu
#SBATCH -G 1
#SBATCH -t 10

CMD="rm -rf arborx-md*"
echo $CMD
$CMD

CMD="srun --ntasks-per-node 1 dcgmi profile --pause"
echo $CMD
$CMD

CMD="srun hpcrun -e gpu=nvidia,pc -o arborx-md-pc.m ArborX/examples/molecular_dynamics/ArborX_Example_MolecularDynamics.exe"
echo $CMD
$CMD

CMD="srun hpcrun -e CPUTIME -e gpu=nvidia -t -o arborx-md.m ArborX/examples/molecular_dynamics/ArborX_Example_MolecularDynamics.exe"
echo $CMD
$CMD

CMD="srun --ntasks-per-node 1 dcgmi profile --resume"
echo $CMD
$CMD

CMD="hpcstruct --gpucfg yes arborx-md-pc.m"
echo $CMD
$CMD

CMD="hpcprof -o arborx-md-pc.d arborx-md-pc.m"
echo $CMD
$CMD

CMD="hpcstruct --gpucfg no arborx-md.m"
echo $CMD
$CMD

CMD="hpcprof -o arborx-md.d arborx-md.m"
echo $CMD
$CMD

echo "echo > submit-done"
echo > submit-done
