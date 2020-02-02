all:
	echo specify one of the possible targets: 
	echo \tbuild: build laghos and its supporting code
	echo \trun:  use hpctoolkit to collect, analyze, and present information about gpu performance 
	echo \trun-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance 

build:
	sh build.sh

run:
	sh run_hpcrun.sh

run-pc:
	sh run_hpcrun_pc.sh

clean:
	/bin/rm -rf build
