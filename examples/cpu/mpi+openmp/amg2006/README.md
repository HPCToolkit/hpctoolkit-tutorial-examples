MPI + OpenMP example: AMG2006 benchmark

1. set up your environment
	module load hpctoolkit
	source setup-env/theta.sh

2. download and build AMG2006
	make build

3. run the application and measure its performance: submit a measurement run to the job manager
	make run

4.a analyze measurement data for a small experiment serially on the login node
	make analyze 
or

4.b analyze measurement data for a larger experiment on the compute nodes
	make analyze-parallel

5. interactively explore traces with hpctraceviewer GUI
   	hpctraceviewer hpctoolkit-amg2006.d

6. interactively explore profiles with hpctraceviewer GUI
   	hpcviewer hpctoolkit-amg2006.d

NOTE: the directories used for hpctoolkit measurements and analysis results are non-standard
      and are used for convenience of this canned tutorial. by default, directories of 
      measurement data and analysis result have a job manager job id embedded in their
      directory names. the scripts here avoid that convention and use explicit names to 
      simplify automation. 
