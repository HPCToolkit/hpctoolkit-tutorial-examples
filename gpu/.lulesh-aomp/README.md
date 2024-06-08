Quicksilver Monte-Carlo mini-app 

This example highlights HPCToolkit's ability to recover approximate calling 
contexts and loop nesting structure in optimized GPU code.

Note: Due to deficiencies in NVIDIA's nvdisasm in CUDA 10, we recommend using
CUDA 11 for this example; otherwise, recovery of GPU calling contexts and loop
analysis will be compromised.

Instructions for this example 

1. set up your enviroment

	source setup-env/<machine>.sh

2. download and build the example

	make build

3. collect kernel-level profile and trace data

	make run

4. view the kernel-level profile and trace data with 
	
	make view

5. collect detailed gpu profile using pc-sampling

	make run-pc

6. view the detailed profile data with 

	make view-pc
