all:
	@echo specify one of the possible targets: 
	@echo "	build: build miniqmc"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	run: use hpctoolkit to collect, analyze, and present kernel-level information about gpu performance "
	@echo "	clean: remove performance data"
	@echo "	veryclean: remove build and performance data"

build:
	/bin/rm -rf AMG2006 tarfile
	time sh make-scripts/build.sh

run:
	sh make-scripts/run_amg.sh

analyze:
	sh make-scripts/run_profmpi.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct AMG2006 sstruct.in.AMG.FD
	$(CLEAN_CMD)
