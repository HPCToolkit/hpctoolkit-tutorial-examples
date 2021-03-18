PeleC is an adaptive-mesh compressible hydrodynamics code for reacting flows.

This example highlights HPCToolkit's ability to analyze multi-stream multi-rank applications.

Note: Due to deficiencies in NVIDIA's nvdisasm in CUDA 10, we recommend using
CUDA 11 for this example; otherwise, recovery of GPU calling contexts and loop
analysis will be compromised.

Instructions for this example on ORNL's ascent

0. module purge
   this step is to avoid potential conflicts with modules already in your environment from other activities

1. load a new release of hpctoolkit. one will be provided in the "modules" directory in your training project:

    module use /ccsopen/proj/<YOUR PROJECT ID>/modules

2. set up enviroment

    source setup-env/ascent.sh

3. download and build the example

    make build

4. collect kernel-level profile and trace

    make run

5. view the kernel-level profile and trace data with 

    hpcviewer hpctoolkit-PeleC3d.gnu.CUDA.ex-gpu-cuda.d

6. collect detailed gpu profile using pc-sampling

    make run-pc

7. view the detailed profile data with 

    hpcviewer hpctoolkit-PeleC3d.gnu.CUDA.ex-gpu-cuda-pc.d
