--------------------------------------------------------------------------------
    Tutorial: Using HPCToolkit to Measure and Analyze the Performance of 
                        GPU-Accelerated Applications

                         ECP Project WBS 2.3.2.08

                  John Mellor-Crummey (Rice University)
                     Keren Zhou (Rice University)

                         ECP Annual Meeting
                          February 5, 2020 

--------------------------------------------------------------------------------

This directory contains scripts to build and run LAMMPS to demonstrate
GPU performance measurement on a single node with 4 MPI ranks and 
4 GPUs.

To build LAMMPS, you need to set the following environment variables:

        CUDA_HOME: the top-level directory of a CUDA installation
        MPI_HOME: the top-level directory of an MPI installation

Your path must contain a version of cmake newer than version 3.3
Your path must contain a version of gcc newer than version 6.4
