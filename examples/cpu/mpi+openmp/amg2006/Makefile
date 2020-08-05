all:
	@echo specify one of the possible targets: 
	@echo "	build: build amg2006"
	@echo "	run: use hpctoolkit to collect measurements about the performance of amg2006"
	@echo "	analyze: use hpctoolkit to analyze performance measurements and attribute back to source code"
	@echo "	clean: remove build and performance data"

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
