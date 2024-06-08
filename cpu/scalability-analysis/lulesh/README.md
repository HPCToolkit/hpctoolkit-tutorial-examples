Analysis of thread scaling with LLNL's Lulesh
---------------------------------------------

1. Set up your environment

	source setup-env/cori.sh

2. Download and build lulesh

	make build

3. Submit a job to the job manager to run lulesh at two different thread
   counts and measure its performance in each case.

	make run

4. Combine the measurement data from the two experiments into a
   measurement database for manual scalability analysis

	make analyze 

5. Interactively explore the profiles with hpcviewer. Use hpcviewer's
   ability to compute derived metrics to compute inclusive scalability
   losses for analysis in the top-down view and exclusive scalability
   losses for analysis in the bottom-up view.

   	make view

6. See EXERCISE for details about how to pinpoint and quantify scalability
   losses in these executions.


NOTE: The directories used for hpctoolkit measurements and analysis
      results are non-standard and are used for convenience of this
      canned tutorial. By default, directories of measurement data
      and analysis result have a job manager job id embedded in their
      directory names. The scripts here avoid that convention and use
      explicit names to simplify automation.
