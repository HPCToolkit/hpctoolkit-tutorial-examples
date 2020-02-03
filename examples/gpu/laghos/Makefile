all:
	@echo specify one of the possible targets: 
	@echo "	build: build laghos and its supporting code"
	@echo "	trun:  use hpctoolkit to collect, analyze, and present information about gpu performance "
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	clean: remove performance data"
	@echo "	veryclean: remove build and performance data"

build:
	time sh build.sh

run-short:
	time sh run_hpcrun_short.sh

run-long:
	time sh run_hpcrun_long.sh

run-pc:
	time sh run_hpcrun_pc.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct laghos

veryclean: clean
	/bin/rm -rf build

