RDY=$(HPCTOOLKIT_TUTORIAL_GPU_MINIQMC_READY)

all:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	build: build miniqmc"
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	clean: remove build and performance data"

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_MINIQMC_BUILD)" \
	  sh make-scripts/check.sh make-scripts/build.sh

run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_MINIQMC_RUN)" \
	  sh make-scripts/check.sh make-scripts/run_hpcrun.sh

view:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-qs-gpu-cuda" \
	  sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct info*.xml log*

veryclean: clean
	/bin/rm -rf miniqmc .build*
