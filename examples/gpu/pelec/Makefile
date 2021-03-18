all:
	@echo specify one of the possible targets: 
	@echo "	build: build PeleC"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	clean: remove performance data"
	@echo "	veryclean: remove build and performance data"

build:
	time sh make-scripts/build.sh

run-pc:
	time sh make-scripts/run_hpcrun_pc.sh

run:
	time sh make-scripts/run_hpcrun.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct

veryclean:
	/bin/rm -rf hpctoolkit* *.hpcstruct PeleC .build*
