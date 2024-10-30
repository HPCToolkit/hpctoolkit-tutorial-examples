RDY=$(findstring ArborX,$(HPCTOOLKIT_EXAMPLE))

avail:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	all: build and run ArborX"
	@echo "	build: build Arborx"
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: delete performance data and logs"
	@echo "	veryclean: delete build, performance data, and logs"

all: build run

build:
	READY=$(RDY) CMD="sh make-scripts/build.sh" sh make-scripts/check.sh sh

run: 
	@READY=$(RDY) CMD="$(HPCTOOLKIT_ARBORX_RUN)" \
		sh make-scripts/check.sh make-scripts/run_hpcrun.sh | tee log.hpcrun$(QA_TEST_VARIANT)

run-pc: 
	@READY=$(RDY) CMD="$(HPCTOOLKIT_ARBORX_RUN_PC)" \
		sh make-scripts/check.sh make-scripts/run_hpcrun_pc.sh | tee log.hpcrun-pc$(QA_TEST_VARIANT)

view:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-arborx-md" \
	      	sh make-scripts/check.sh make-scripts/view.sh


view-pc:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-arborx-md-pc" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit*
	/bin/rm -rf log.*

veryclean: clean
	rm -rf kokkos
	rm -rf ArborX build-done

distclean: veryclean


.PHONY: build-done
.PHONY: run-done


