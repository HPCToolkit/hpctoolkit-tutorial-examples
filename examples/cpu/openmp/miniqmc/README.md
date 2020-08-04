This example showcases HPCToolkit's support for OpenMP programs using GCC or IBM XL compilers.

Instructions for this example on ORNL's ascent

0. module purge
   this step is to avoid potential conflicts with modules already in your environment from other activities

1. load a new release of hpctoolkit. one will be provided in the "modules" directory in your training project:

   module use /ccsopen/proj/<YOUR PROJECT ID>/modules
   module load hpctoolkit/2020.08

2. there are three options for setting up the software
   using GCC: source setup-env/ascent-gcc.sh
   using IBM XL compilers: source setup-env/ascent-xl.sh

3. (optional) if you want to try out hpctoolkit's support for the OMPT OpenMP performance tools interface, 
   at present, you must load a module supplying a special version of the openmp runtime:

   module use /ccsopen/proj/<YOUR PROJECT ID>/modules
   module load openmp/ompt

4. make build

5. make run

6. view the trace data with 
     hpctraceviewer hpctoolkit-miniqmc-gpu.d

7. view the profile data with 
     hpcviewer hpctoolkit-miniqmc-gpu.d
