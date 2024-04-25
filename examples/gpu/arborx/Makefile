RDY=$(findstring ArborX,$(HPCTOOLKIT_EXAMPLE))
avail:
	@echo
	@echo Specify one of the possible targets: 
	@echo "	build: build quicksilver"
	@echo "	run: use hpctoolkit to collect, analyze, and present both kernel and instruction-level information about gpu performance "
	@echo "	view: use hpcviewer to inspect performance data gathered using 'run'"
	@echo "	view-pc: use hpcviewer to inspect performance data gathered using 'run-pc'"
	@echo "	clean: delete performance data and logs"
	@echo "	veryclean: delete build, performance data, and logs"

build:
	READY=$(RDY) CMD="sh scripts/build.sh" sh scripts/check.sh sh

run: 
	READY=$(RDY) CMD="sbatch scripts/submit.sh" sh scripts/check.sh 

view:
	hpcviewer arborx-md.d

view-pc:
	hpcviewer arborx-md-pc.d

clean:
	rm -rf arborx-md* submit-done slurm*

veryclean: clean
	rm -rf ArborX build-done

distclean: veryclean
	rm -rf hpcstruct-cache


.PHONY: build-done
.PHONY: run-done


