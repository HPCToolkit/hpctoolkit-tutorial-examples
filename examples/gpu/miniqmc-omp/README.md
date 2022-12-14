This example showcases the ability to profile OpenMP including offload using IBM's XL compiler.  

Instructions for this example on ORNL's ascent

0. module purge
   this step is to avoid potential conflicts with modules already in your environment from other activities

1. load a new release of hpctoolkit. one will be provided in the "modules" directory in your training project:

   module use /ccsopen/proj/<YOUR PROJECT ID>/modules
   module load hpctoolkit/2020.08

2. source setup-env/ascent-xl-offload.sh

3. make build

4. make run

5. view the trace data with 
     hpctraceviewer hpctoolkit-miniqmc-gpu-openmp.d

6. view the profile data with 
     hpcviewer hpctoolkit-miniqmc-gpu-openmp.d

NOTES:
This example is configured to use CUDA 10. Trying to configure with CUDA 11 resulted in an error message
about there being some mismatch related to BLAS.
