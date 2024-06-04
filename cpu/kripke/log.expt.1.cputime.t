   runqahpct/home/msi3/gits/hpctoolkit-tutorial-examples/examples/cpu/kripke     Mon May 27 14:45:13 CDT 2024     expt.1.cputime.t
Currently Loaded Modulefiles:
 1) studio/version12.6   9) meson/1.2.2                            17) gmake/4.4.1-gcc-11.4.0-3ejcrnh                  
 2) hpctoolkit/msi3     10) python/3.11.6                          18) ncurses/6.5-gcc-11.4.0-43soscc                  
 3) openjdk/17.0.8      11) glibc/2.28-gcc-11.4.0-kqxauf2          19) cmake/3.27.9-gcc-11.4.0-mozbnry                 
 4) hpcviewer/2024.05   12) gcc-runtime/11.4.0-gcc-11.4.0-tumbkdc  20) openmpi/4.1.5/cpu                               
 5) gcc/11.4.0          13) nghttp2/1.61.0-gcc-11.4.0-tom2xdr      21) QAHPCT/2024.03                                  
 6) gdb/11.2            14) zlib-ng/2.1.6-gcc-11.4.0-co3qboq       22) rocm/6.0.0                                      
 7) autotools           15) openssl/3.3.0-gcc-11.4.0-kz62fcd       23) rocm/5.6.0                                      
 8) py-pip/23.1.2       16) curl/8.7.1-gcc-11.4.0-l6pnvor          24) hpctoolkit/2024.01.stable/cuda11.8.0-rocm6.0.0  
   Begin QA runqahpct expt.1.cputime.t in directory /home/msi3/gits/hpctoolkit-tutorial-examples/examples/cpu/kripke
   Target executable = Kripke/Kripke/build/kripke.exe 
    hpcrun arguments = " -e CPUTIME -t" 
     No GPU profiling requested
     Tracing is requested

 runqahpct Launching timeout -s6 90  /usr/bin/time -f"timefmt" hpcrun -o meas.expt.1.cputime.t  -e CPUTIME -t Kripke/Kripke/build/kripke.exe  

   _  __       _         _
  | |/ /      (_)       | |
  | ' /  _ __  _  _ __  | | __ ___
  |  <  | '__|| || '_ \ | |/ // _ \ 
  | . \ | |   | || |_) ||   <|  __/
  |_|\_\|_|   |_|| .__/ |_|\_\\___|
                 | |
                 |_|        Version 1.2.5-dev

LLNL-CODE-775068

Copyright (c) 2014-23, Lawrence Livermore National Security, LLC

Kripke is released under the BSD 3-Clause License, please see the
LICENSE file for the full license

This work was produced under the auspices of the U.S. Department of
Energy by Lawrence Livermore National Laboratory under Contract
DE-AC52-07NA27344.

Author: Adam J. Kunen <kunen1@llnl.gov>

Compilation Options:
  Architecture:           Sequential
  Compiler:               /opt/nvidia/hpc_sdk/Linux_x86_64/22.3/compilers/bin/nvc++
  Compiler Flags:         "    "
  Linker Flags:           " "
  CHAI Enabled:           No
  CUDA Enabled:           No
  MPI Enabled:            No
  OpenMP Enabled:         No
  Caliper Enabled:        No

Input Parameters
================

  Problem Size:
    Zones:                 16 x 16 x 16  (4096 total)
    Groups:                32
    Legendre Order:        4
    Quadrature Set:        Dummy S2 with 96 points

  Physical Properties:
    Total X-Sec:           sigt=[0.100000, 0.000100, 0.100000]
    Scattering X-Sec:      sigs=[0.050000, 0.000050, 0.050000]

  Solver Options:
    Number iterations:     10

  MPI Decomposition Options:
    Total MPI tasks:       1
    Spatial decomp:        1 x 1 x 1 MPI tasks
    Block solve method:    Sweep

  Per-Task Options:
    DirSets/Directions:    8 sets, 12 directions/set
    GroupSet/Groups:       2 sets, 16 groups/set
    Zone Sets:             1 x 1 x 1
    Architecture:          Sequential
    Data Layout:           DGZ

Generating Problem
==================

  Decomposition Space:   Procs:      Subdomains (local/global):
  ---------------------  ----------  --------------------------
  (P) Energy:            1           2 / 2
  (Q) Direction:         1           8 / 8
  (R) Space:             1           1 / 1
  (Rx,Ry,Rz) R in XYZ:   1x1x1       1x1x1 / 1x1x1
  (PQR) TOTAL:           1           16 / 16

  Material Volumes=[8.789062e+03, 1.177734e+05, 2.753438e+06]

  Memory breakdown of Field variables:
  Field Variable            Num Elements    Megabytes
  --------------            ------------    ---------
  data/sigs                        15360        0.117
  dx                                  16        0.000
  dy                                  16        0.000
  dz                                  16        0.000
  ell                               2400        0.018
  ell_plus                          2400        0.018
  i_plane                         786432        6.000
  j_plane                         786432        6.000
  k_plane                         786432        6.000
  mixelem_to_fraction               4352        0.033
  phi                            3276800       25.000
  phi_out                        3276800       25.000
  psi                           12582912       96.000
  quadrature/w                        96        0.001
  quadrature/xcos                     96        0.001
  quadrature/ycos                     96        0.001
  quadrature/zcos                     96        0.001
  rhs                           12582912       96.000
  sigt_zonal                      131072        1.000
  volume                            4096        0.031
  --------                  ------------    ---------
  TOTAL                         34238832      261.222

  Generation Complete!

Steady State Solve
==================

  iter 0: particle count=3.743744e+07, change=1.000000e+00
  iter 1: particle count=5.629276e+07, change=3.349511e-01
  iter 2: particle count=6.569619e+07, change=1.431351e-01
  iter 3: particle count=7.036907e+07, change=6.640521e-02
  iter 4: particle count=7.268400e+07, change=3.184924e-02
  iter 5: particle count=7.382710e+07, change=1.548355e-02
  iter 6: particle count=7.438973e+07, change=7.563193e-03
  iter 7: particle count=7.466578e+07, change=3.697158e-03
  iter 8: particle count=7.480083e+07, change=1.805479e-03
  iter 9: particle count=7.486672e+07, change=8.801810e-04
  Solver terminated

Timers
======

  Timer                    Count       Seconds
  ----------------  ------------  ------------
  Generate                     1       0.00304
  LPlusTimes                  10       0.80365
  LTimes                      10       0.76379
  Population                  10       0.11784
  Scattering                  10       3.69577
  Solve                        1       7.45171
  Source                      10       0.00134
  SweepSolver                 10       1.94513
  SweepSubdomain             160       1.91725

TIMER_NAMES:Generate,LPlusTimes,LTimes,Population,Scattering,Solve,Source,SweepSolver,SweepSubdomain
TIMER_DATA:0.003043,0.803647,0.763787,0.117836,3.695773,7.451711,0.001340,1.945135,1.917248

Figures of Merit
================

  Throughput:         1.688594e+07 [unknowns/(second/iteration)]
  Grind time :        5.922088e-08 [(seconds/iteration)/unknowns]
  Sweep efficiency :  98.56633 [100.0 * SweepSubdomain time / SweepSolver time]
  Number of unknowns: 12582912

END
7.40s. user;  0.09s. system;  7.55s. elapsed;  99%%CPU (0avgtext+0avgdata 282836maxresident)k
   -------------------------------------- Data collection complete Mon May 27 14:45:21 CDT 2024 
    Target-runtime= 8 s. = 0m.:8s.; log.expt.1.cputime.t
 
SUMMARY: samples: 1243 (recorded: 1243, blocked: 0, errant: 0, trolled: 0, yielded: 0),
    No runtime errors found.
  Experiment hpcrun files: 1 Total, Target CPU threads = 1, Target GPU threads = 0
-rw-r--r-- 1 msi3 users 15472 May 27 14:45 meas.expt.1.cputime.t/kripke.exe-000000-000-2a803c80-3376862-0.hpcrun
  Experiment hpctrace files: Target CPU traces = 1, Target GPU traces = 0
-rw-r--r-- 1 msi3 users 14960 May 27 14:45 meas.expt.1.cputime.t/kripke.exe-000000-000-2a803c80-3376862-0.hpctrace
   --------------------------------------  

 runqahpct Launching /usr/bin/time -f"timefmt" hpcstruct  meas.expt.1.cputime.t  >> log.expt.1.cputime.t 2>&1
INFO: Using structure cache directory /home/msi3/MYSTRUCTCACHE

INFO: Using a pool of 48 threads to analyze binaries in a measurement directory
INFO: Analyzing each large binary of >= 100000000 bytes in parallel using 16 threads
INFO: Analyzing each small binary using 2 threads

INFO: identifying load modules that need binary analysis

 begin parallel analysis of CPU binary libc-2.28.so (size = 2089992, threads = 2)
 begin parallel analysis of CPU binary kripke.exe (size = 3342744, threads = 2)
 begin parallel analysis of CPU binary libmonitor.so.0.0.0 (size = 305688, threads = 2)
   end parallel analysis of CPU binary libmonitor.so.0.0.0 (Copied from cache)
   end parallel analysis of CPU binary libc-2.28.so (Copied from cache)
   end parallel analysis of CPU binary kripke.exe (Copied from cache)

0.11s. user;  0.17s. system;  0.13s. elapsed;  222%%CPU (0avgtext+0avgdata 16768maxresident)k
    hpcstruct-runtime= 0 s. = 0m.:0s.; log.expt.1.cputime.t
  Experiment gpubins-used: 0
    No hpcstruct errors found.
   --------------------------------------  

 runqahpct Launching /usr/bin/time -f"timefmt" hpcprof  -o dbase.expt.1.cputime.t meas.expt.1.cputime.t  >> log.expt.1.cputime.t 2>&1
3.10s. user;  0.38s. system;  0.39s. elapsed;  884%%CPU (0avgtext+0avgdata 23968maxresident)k
    hpcprof-runtime= 0 s. = 0m.:0s.; log.expt.1.cputime.t
    No hpcprof errors found.

   ==========================================================
     TESTPASS; -- 8 s. = 0m.:8s. ; see /home/msi3/gits/hpctoolkit-tutorial-examples/examples/cpu/kripke/log.expt.1.cputime.t
Mon May 27 14:45:21 CDT 2024
