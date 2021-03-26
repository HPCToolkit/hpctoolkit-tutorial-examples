all:
	@echo specify one of the possible targets: 
	@echo "	build: build laghos and its supporting code"
	@echo "	run-short: use hpctoolkit to collect and analyze information about gpu performance about a short run"
	@echo "	run-long: use hpctoolkit to collect and analyze information about gpu performance about a long run"
	@echo "	run-pc: use hpctoolkit to collect and analyze instruction-level information about gpu performance "
	@echo "	view-short: use hpcviewer to inspect performance data of the short run"
	@echo "	view-long: use hpcviewer to inspect performance data of the long run"
	@echo "	view-pc: use hpcviewer to inspect performance data from pc sampling"
	@echo "	clean: remove performance data"
	@echo "	veryclean: remove build and performance data"

build:
	 $(HPCTOOLKIT_LAGHOS_BUILD) make-scripts/build.sh

run-short:
	SUBMIT="$(HPCTOOLKIT_LAGHOS_RUN_SHORT)" sh make-scripts/submit.sh make-scripts/run_hpcrun_short.sh

run-long:	
	SUBMIT="$(HPCTOOLKIT_LAGHOS_RUN_LONG)" sh make-scripts/submit.sh make-scripts/run_hpcrun_long.sh

run-pc:
	SUBMIT="$(HPCTOOLKIT_LAGHOS_RUN_PC)" sh make-scripts/submit.sh make-scripts/run_hpcrun_pc.sh

view-short:
	DB=hpctoolkit-laghos-short sh make-scripts/view.sh

view-long:
	DB=hpctoolkit-laghos-long sh make-scripts/view.sh

view-pc:
	DB=hpctoolkit-laghos-pc sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct 
	/bin/rm -rf log*

veryclean: clean
	/bin/rm -rf build .build_*

