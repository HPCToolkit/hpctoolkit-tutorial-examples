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
	/bin/rm -rf AMG2013 tarfile
	time sh make-scripts/build.sh

run:
	sh make-scripts/run_amg.sh

analyze:
	sh make-scripts/run_prof.sh

analyze-parallel:
	sh make-scripts/run_profmpi.sh

view:
	sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct AMG2013 sstruct.in.MG.FD slurm*
	/bin/rm -rf AMG2013 tarfile
	$(CLEAN_CMD)
