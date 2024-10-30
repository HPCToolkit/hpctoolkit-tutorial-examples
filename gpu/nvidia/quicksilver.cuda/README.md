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

NOTE: the make view and make view-pc will launch hpcviewer. This assumes that you are running
in an X11 desktop with your DISPLAY variable set appropriately.

5. view the kernel-level profile and trace data with
	
   make view

6. view the detailed profile data with

   make view-pc


There are two other options for viewing performance data:

You can download hpcviewer onto your laptop or desktop from
https://hpctoolkit.org/download.html. hpcviewer uses Java. You will need
a version of Java 17 or Java 21 on your system. If you don't have Java
installed, see the instructions on the download page for where to obtain
a copy of the Java JDK.

To view your performance measurements with a copy of hpcviewer on your laptop,
you can always tar up a copy of a hpcviewer database produced by hpcprof.

If hpcserver is installed on the Linux system where you are collecting performance
data, you can use hpcviewer's "Open remote database" on the File tab to open
the data directly from the remote system.
