all:
	@echo specify one of the possible targets: 
	@echo "	build: build PeleC"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	clean: remove performance data and logs"
	@echo "	veryclean: remove build, performance data, and logs"

build:
	$(HPCTOOLKIT_PELEC_BUILD) make-scripts/build.sh

run-pc:
	 SUBMIT="$(HPCTOOLKIT_PELEC_RUN_PC)" sh make-scripts/submit.sh make-scripts/run_hpcrun_pc.sh

run:
	 SUBMIT="$(HPCTOOLKIT_PELEC_RUN)" sh make-scripts/submit.sh make-scripts/run_hpcrun.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct 
	/bin/rm -rf log*

veryclean: clean
	/bin/rm -rf PeleC .build* 
