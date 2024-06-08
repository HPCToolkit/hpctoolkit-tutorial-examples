all-gpu-data -- results of running hpctoolkit are being provided here
in case the inability of NERSC training accounts to access GPUs on Cori isn't resolved

The code shows a brief run of a code with 1 rank, 12 threads, and 32 GPU streams

Instructions for this example 

1. set up your enviroment

	source setup-env/cori.sh

2. download the measurement results for all of the GPU applications

	make download


3. inspect the performance data for the GPU applications in the subdirectory hpctoolkit-cori-data

