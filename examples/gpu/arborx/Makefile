RDY=$(findstring ArborX,$(HPCTOOLKIT_EXAMPLE))
avail:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	all: build and run ArborX"
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
	rm -rf log.hpcrun$(QA_TEST_VARIANT)
	READY=$(RDY) CMD="$(HPCTOOLKIT_ARBORX_RUN)" \
		sh make-scripts/check.sh make-scripts/run_hpcrun.sh 2>&1 | tee log.hpcrun$(QA_TEST_VARIANT)

run-pc:
	rm -rf log.hpcrun$(QA_TEST_VARIANT)-pc
	READY=$(RDY) CMD="$(HPCTOOLKIT_ARBORX_RUN_PC)" \
		sh make-scripts/check.sh make-scripts/run_hpcrun_pc.sh	2>&1 | tee log.hpcrun$(QA_TEST_VARIANT)-pc

view:
	@READY=$(RDY) CMD=sh DB="arborx-md$(QA_TEST_VARIANT)" \
		sh make-scripts/check.sh make-scripts/view.sh

view-pc:
	@READY=$(RDY) CMD=sh DB="arborx-md$(QA_TEST_VARIANT)-pc" \
		sh make-scripts/check.sh make-scripts/view.sh

clean:
	rm -rf arborx-md* submit-done slurm* log.hpc*

veryclean: clean
	rm -rf ArborX* log.build*

distclean: veryclean
	rm -rf hpcstruct-cache

.PHONY: build-done
.PHONY: run-done
