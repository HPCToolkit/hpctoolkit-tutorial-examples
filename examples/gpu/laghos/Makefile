EXEC=laghos
RDY=$(HPCTOOLKIT_TUTORIAL_GPU_LAGHOS_READY) 

all:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	build: build Laghos"
	@echo "	run-short: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	run-long: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-short: use hpcviewer to inspect performance data gathered using 'run-short'"
	@echo "	view-long: use hpcviewer to inspect performance data gathered using 'run-long'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: delete performance data and logs"
	@echo "	veryclean: delete build, performance data, and logs"
	@echo

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_LAGHOS_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/build.sh

run-short:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_LAGHOS_RUN_SHORT)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun_short.sh

run-long:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_LAGHOS_RUN_LONG)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun_long.sh

run-pc:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_LAGHOS_RUN_PC)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun_pc.sh

view-short:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-$(EXEC)-short" \
	      	sh make-scripts/check.sh make-scripts/view.sh

view-long:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-$(EXEC)-long" \
	      	sh make-scripts/check.sh make-scripts/view.sh

view-pc:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-$(EXEC)-pc" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct 
	/bin/rm -rf log* .build*

veryclean: clean
	/bin/rm -rf laghos 
