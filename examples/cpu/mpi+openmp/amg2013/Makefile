RDY=$(findstring amg2013,$(HPCTOOLKIT_EXAMPLE))

all:
	@echo ""
	@echo specify one of the possible targets: 
	@echo "	build: build amg2013"
	@echo "	run: use hpctoolkit to collect measurements about the CPU performance of amg2013"
	@echo "	analyze: use hpcprof to analyze performance measurements serially and attribute back to source code"
	@echo "	analyze-parallel: use hpcprof-mpi to analyze performance measurements in parallel and attribute back to source code"
	@echo "	view: invoke hpcviewer to inspect results of measurement and analysis"
	@echo "	clean: remove build and performance data"
	@echo ""
	@echo "	NOTE: it is quicker to analyze the small measurement data on the login node using 'make analyze'"
	@echo ""

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/build.sh

run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_RUN)" \
	      	sh make-scripts/check.sh make-scripts/amg2013.sh

analyze:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_ANALYZE)" \
	      	sh make-scripts/check.sh make-scripts/prof.sh

analyze-parallel:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_ANALYZE)" \
	      	sh make-scripts/check.sh make-scripts/profmpi.sh

view:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_VIEW)" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* sstruct.in.MG.FD *core*
	/bin/rm -rf error.* output.* .build* log.*

veryclean: clean
	/bin/rm -rf AMG2013 tarfile
	$(CLEAN_CMD)
