#!/bin/bash

# turn off buggy glibc support for LD_AUDIT used by hpctoolkit
hpcrun --disable-auditor -o julia.m julia mb.jl
hpcstruct julia.m
hpcprof -o julia.d julia.m
