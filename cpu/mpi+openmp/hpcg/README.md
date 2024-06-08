                 MPI + OpenMP example: HPCG benchmark
-----------------------------------------------------------------------

1. Set up your environment

	module load hpctoolkit
	source setup-env/cori.sh

2. Download and build xhpcg

	make build

3. Run the application and measure its performance: submit a measurement
   run to the job manager

	make run

4.a Analyze measurement data for a small experiment serially on the
    login node

	make analyze 

or

4.b Analyze measurement data for a larger experiment on the compute nodes

	make analyze-parallel

5. Interactively explore profiles and traces with hpcviewer

   	make view

6. See EXERCISES for some guidance of what and how to explore.

NOTE: the directories used for hpctoolkit measurements and analysis
      results are non-standard and are used for convenience of this
      tutorial. by default, directories of measurement data and analysis
      result have a job manager job id embedded in their directory
      names. the scripts here avoid that convention and use explicit
      names to simplify automation.
