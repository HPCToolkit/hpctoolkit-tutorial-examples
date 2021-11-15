RDY=$(findstring hpcg,$(HPCTOOLKIT_EXAMPLE))

all:
	@echo ""
	@echo specify one of the possible targets: 
	@echo "	build: build xhpcg"
	@echo "	run: use hpctoolkit to collect measurements about the CPU performance of xhpcg"
	@echo "	analyze: use hpcprof to analyze performance measurements serially and attribute back to source code"
	@echo "	analyze-parallel: use hpcprof-mpi to analyze performance measurements in parallel and attribute back to source code"
	@echo "	view: invoke hpcviewer to inspect results of measurement and analysis"
	@echo "	clean: remove build and performance data"
	@echo ""
	@echo "	NOTE: it is quicker to analyze the small measurement data on the login node using 'make analyze'"
	@echo ""

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_HPCG_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/build.sh

run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_HPCG_RUN)" \
	      	sh make-scripts/check.sh make-scripts/xhpcg.sh

analyze:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_HPCG_ANALYZE)" \
	      	sh make-scripts/check.sh make-scripts/prof.sh

analyze-parallel:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_HPCG_ANALYZE)" \
	      	sh make-scripts/check.sh make-scripts/profmpi.sh

view:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_HPCG_VIEW)" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* 
	 /bin/rm -rf  hpcg2*.txt HPCG-*.txt .build* *core* slurm*
	/bin/rm -rf .build* log.*

veryclean: clean
	/bin/rm -rf src build tarfile
	$(CLEAN_CMD)
