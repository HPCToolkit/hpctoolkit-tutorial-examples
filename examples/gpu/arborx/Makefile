RDY=$(findstring ArborX,$(HPCTOOLKIT_EXAMPLE))
avail:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	all: build and run ArborX"
	@echo "	build: build Arborx"
	@echo "	run: use hpctoolkit to collect, analyze, and present both kernel and instruction-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: delete performance data and logs"
	@echo "	veryclean: delete build, performance data, and logs"

all: build run

build:
	READY=$(RDY) CMD="sh make-scripts/build.sh" sh make-scripts/check.sh sh

run: 
	READY=$(RDY) CMD="sbatch make-scripts/submit.sh" sh make-scripts/check.sh 

view:
	hpcviewer arborx-md.d

view-pc:
	hpcviewer arborx-md-pc.d

clean:
	rm -rf arborx-md* submit-done slurm*

veryclean: clean
	rm -rf ArborX* build-done .build*

distclean: veryclean
	rm -rf hpcstruct-cache


.PHONY: build-done
.PHONY: run-done


