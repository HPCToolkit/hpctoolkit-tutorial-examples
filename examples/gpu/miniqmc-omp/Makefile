RDY=$(findstring miniqmc,$(HPCTOOLKIT_EXAMPLE))


all:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	build: build miniqmc"
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	run-pc: (NVIDIA GPUs only) use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: remove build and performance data"
	@echo "	veryclean: delete build, performance data, and logs"
	@echo

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_MINIQMC_BUILD)" \
	  sh make-scripts/check.sh make-scripts/build.sh

run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_MINIQMC_RUN)" \
	  sh make-scripts/check.sh make-scripts/run_hpcrun.sh

run-pc:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_MINIQMC_RUN_PC)" \
	  sh make-scripts/check.sh make-scripts/run_hpcrun_pc.sh

view:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-miniqmc-gpu-openmp" \
	  sh make-scripts/check.sh make-scripts/view.sh

view-pc:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-miniqmc-gpu-openmp-pc" \
	  sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct info*.xml log*

veryclean: clean
	/bin/rm -rf miniqmc .build*
