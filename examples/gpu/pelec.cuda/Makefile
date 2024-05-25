EXEC=PeleC-TG
RDY=$(findstring pelec,$(HPCTOOLKIT_EXAMPLE))

all:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	build: build PeleC"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: delete performance data and logs"
	@echo "	veryclean: delete build, performance data, and logs"
	@echo

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_PELEC_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/build.sh | tee log.build

run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_PELEC_RUN)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun.sh | tee log.hpcrun

run-pc:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_PELEC_RUN_PC)" \
	      	sh make-scripts/check.sh make-scripts/run_hpcrun_pc.sh | tee log.hpcrun-pc

view:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-$(EXEC)-gpu-{HPCTOOLKIT_PELEC_GPU_PLATFORM}" \
	      	sh make-scripts/check.sh make-scripts/view.sh

view-pc:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-$(EXEC)-gpu-cuda-pc" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* dir.*
	/bin/rm -rf log.hp*
	/bin/rm -f Backtrace.* datlog ic.txt

distclean veryclean: clean
	/bin/rm -rf PeleC 
	/bin/rm -f log.build 
