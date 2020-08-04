Quicksilver Monte-Carlo mini-app 

This example highlights HPCToolkit's ability to recover approximate calling 
contexts and loop nesting structure in optimized GPU code.

Note: Due to deficiencies in NVIDIA's nvdisasm in CUDA 10, we recommend using
CUDA 11 for this example; otherwise, recovery of GPU calling contexts and loop
analysis will be compromised.

Instructions for this example on ORNL's ascent

0. module purge
   this step is to avoid potential conflicts with modules already in your environment from other activities

1. load a new release of hpctoolkit. one will be provided in the "modules" directory in your training project:

	module use /ccsopen/proj/<YOUR PROJECT ID>/modules
	module load hpctoolkit/2020.08

2. set up enviroment

	source setup-env/ascent.sh

3. download and build the example

	make build

4. view the profile data with 

     hpcviewer hpctoolkit-qs-gpu-cuda.d

5. collect detailed gpu profile using pc-sampling

	make run-pc

6. view the detailed profile data with 

     hpcviewer hpctoolkit-qs-gpu-cuda-pc.d

7. collect kernel-level profile and trace

	make run

8. view the kernel-level profile data with 

	hpcviewer hpctoolkit-qs-gpu-cuda.d

9. view the trace data with 

	hpctraceviewer hpctoolkit-qs-gpu-cuda.d

