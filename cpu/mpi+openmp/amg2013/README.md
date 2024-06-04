               MPI + OpenMP example: AMG2013 benchmark
------------------------------------------------------------------------

1. Set up your environment

        export HPCTOOLKIT_TUTORIAL_PROJECTID=<project>
	source setup-env/<machine>.sh

2. Download and build AMG2013

	make build

3. Run the application and measure its performance: submit a measurement
   run to the job manager

	make run

4a. Analyze measurement data for a small experiment serially on the
    login node

	make analyze 
or

4b. Analyze measurement data for a larger experiment on the compute nodes

	make analyze-parallel

5a. Interactively explore traces with hpcviewer GUI on the login node
    (needs VNC or X11 forwarding)

        make view

or

5b. Install the hpcviewer GUI on your local machine,
    transfer the database directory to your local machine,
    and then interactively explore traces with hpcviewer GUI

   	hpcviewer hpctoolkit-amg2013.d

6. Look at EXERCISES for some guidance about how to explore and
   what to look for.

NOTE: The directories used for hpctoolkit measurements and analysis
      results are non-standard and are used for convenience of this
      canned tutorial. by default, directories of measurement data
      and analysis result have a job manager job id embedded in their
      directory names. The scripts here avoid that convention and use
      explicit names to simplify automation.
