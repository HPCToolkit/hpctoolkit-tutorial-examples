Quicksilver Monte-Carlo mini-app 

This example highlights 

- HPCToolkit's ability to recover profile and trace
  GPU-accelerated applications across multiple ranks and GPUs.

- HPCToolkit's ability to using instruction-level sampliing
  within GPU kernels and then attribute measurements to
  calling contexts and loop nests in optimized GPU code.


Instructions for configuring, building, and running the code:


1. Configure the example

   To begin, you will need to set two environment variables: 
       HPCTOOLKIT_TUTORIAL_PROJECTID
       HPCTOOLKIT_TUTORIAL_RESERVATION

   The right setting for HPCTOOLKIT_TUTORIAL_PROJECTID is typically your usual
   project account. If you have a special workshop account needed to use a
   machine reservation, use that.

   export HPCTOOLKIT_TUTORIAL_PROJECTID=<your default project id>

   If there is a special workshop reservation for a queue, use that for 
   HPCTOOLKIT_TUTORIAL_RESERVATION. Otherwise, set HPCTOOLKIT_TUTORIAL_RESERVATION
   to default.

   export HPCTOOLKIT_TUTORIAL_RESERVATION=default

   From the current directory, source the bash setup script for the machine
   on which you are working, e.g. 

   source setup-env/<machine>.sh


2. Download and build the example code

   make build

3. Run the code and collect kernel-level profiles and traces

   make run

4. Run the code and collect PC samples

   make run-pc


   Note: you may be able to have only one of the runs in the queue at one time.
   If so, wait until one run starts or finishes to launch the second run.

5. view the kernel-level profile and trace data with 
	
   make view

6. view the detailed profile data with 

   make view-pc
