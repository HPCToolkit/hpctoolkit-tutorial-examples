This directory contains scripts to build and run Laghos to demonstrate
GPU performance measurement on a single node with 1 MPI rank and one GPU.


Instructions for this example 

1. set up your enviroment

        source setup-env/<machine>.sh

2. download and build the example

        make build

3a. collect kernel-level profile and trace data for a short run

        make run-short

3b. collect kernel-level profile and trace data for a slightly longer run

        make run-long

3c. collect detailed gpu profile using pc-sampling

        make run-pc

4a. view the short kernel-level profile and trace data with 

        make view-short

4b. view the long kernel-level profile and trace data with 

        make view-long

4a. view the PC-sampling measurements of gpu code

        make view-pc
