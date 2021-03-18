--------------------------------------------------------------------------------
    Tutorial: Using HPCToolkit to Measure and Analyze the Performance of 
                        GPU-Accelerated Applications

                         ECP Project WBS 2.3.2.08

                  John Mellor-Crummey (Rice University)
                     Keren Zhou (Rice University)

                         ECP Annual Meeting
                          February 5, 2020 

--------------------------------------------------------------------------------

This directory contains scripts to build and run Laghos to demonstrate
GPU performance measurement on a single node with 4 MPI ranks and 
4 GPUs.

To build laghos:

- your path must contain a version of cmake newer than version 3.3, and
- your path must contain a version of gcc newer than version 6.4.

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

    make run-short

5. view the kernel-level profile and trace data with 

    hpcviewer hpctoolkit-laghos-short.d

6. collect detailed gpu profile using pc-sampling

    make run-pc

7. view the detailed profile data with 

    hpcviewer hpctoolkit-laghos-pc.d

