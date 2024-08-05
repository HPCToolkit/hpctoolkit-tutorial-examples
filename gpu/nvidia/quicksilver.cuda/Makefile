RDY=$(findstring quicksilver,$(HPCTOOLKIT_EXAMPLE))

all:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	build: build quicksilver"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: delete performance data and logs"
	@echo "	veryclean: delete build, performance data, and logs"
	@echo "	distclean: delete build, performance data, and logs"
	@echo

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_QS_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/build.sh | tee log.build$(QA_TEST_VARIANT)


run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_QS_RUN)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun.sh | tee log.hpcrun$(QA_TEST_VARIANT)

run-pc:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_QS_RUN_PC)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun_pc.sh | tee log.hpcrun$(QA_TEST_VARIANT)-pc

view:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-qs" \
	      	sh make-scripts/check.sh make-scripts/view.sh

view-pc:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-qs-pc" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit*
	/bin/rm -rf log.hpcrun*

distclean veryclean: clean
	/bin/rm -rf quicksilver* log.*
