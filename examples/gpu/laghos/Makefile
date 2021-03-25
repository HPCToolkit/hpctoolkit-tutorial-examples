all:
	@echo specify one of the possible targets: 
	@echo "	build: build laghos and its supporting code"
	@echo "	run-short: use hpctoolkit to collect, analyze, and present information about gpu performance about a short run"
	@echo "	run-long: use hpctoolkit to collect, analyze, and present information about gpu performance about a long run"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	clean: remove performance data"
	@echo "	veryclean: remove build and performance data"

build:
	time sh make-scripts/build.sh

run-short:
	JOBNAME=Laghos-SHORT sh make-scripts/submit.sh make-scripts/run_hpcrun_short.sh

run-long:	
	JOBNAME=Laghos-LONG sh make-scripts/submit.sh make-scripts/run_hpcrun_long.sh

run-pc:
	JOBNAME=Laghos-PC sh make-scripts/submit.sh make-scripts/run_hpcrun_pc.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct laghos  error.* output.*

veryclean: clean
	/bin/rm -rf build .build_begin .build_end

