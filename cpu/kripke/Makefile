RDY=$(findstring Kripke,$(HPCTOOLKIT_EXAMPLE))
avail:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	all: build and run Kripke.cuda"
	@echo "	build: build Arborx"
	@echo "	run: use hpctoolkit to collect, analyze, and kernel-level information about gpu performance "
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: delete performance data and logs"
	@echo "	veryclean: delete build, performance data, and logs"

build:
	READY=$(RDY) CMD="sh make-scripts/build.sh" sh make-scripts/check.sh sh | tee log.build$(QA_TEST_VARIANT)

run: 
	READY=$(RDY) CMD="$(HPCTOOLKIT_KRIPKE_RUN)" \
		sh make-scripts/check.sh make-scripts/run_hpcrun.sh 2>&1 | tee log.hpcrun$(QA_TEST_VARIANT)

run-pc:
	READY=$(RDY) CMD="$(HPCTOOLKIT_KRIPKE_RUN_PC)" \
		sh make-scripts/check.sh make-scripts/run_hpcrun_pc.sh	2>&1 | tee log.hpcrun$(QA_TEST_VARIANT)-pc

view:
	@READY=$(RDY) CMD=sh DB="kripke-md$(QA_TEST_VARIANT)" \
		sh make-scripts/check.sh make-scripts/view.sh

view-pc:
	@READY=$(RDY) CMD=sh DB="kripke-md$(QA_TEST_VARIANT)-pc" \
		sh make-scripts/check.sh make-scripts/view.sh

clean:
	rm -rf kripke-md* submit-done slurm* log.hpc*

distclean veryclean: clean
	rm -rf Kripke log.build*

