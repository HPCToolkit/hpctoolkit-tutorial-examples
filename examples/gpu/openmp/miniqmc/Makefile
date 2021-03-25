all:
	@echo specify one of the possible targets: 
	@echo "	build: build miniqmc"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	run: use hpctoolkit to collect and analyze kernel-level information about gpu performance "
	@echo "	clean: remove build and performance data"

build:
	/bin/rm -rf miniqmc
	time sh make-scripts/build.sh

build-miniqmc:
	make -C miniqmc/miniqmc-build

run:
	JOBNAME=RUN sh make-scripts/submit.sh  make-scripts/run_hpcrun.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct info*.xml error.* output.*

veryclean: clean
	/bin/rm -rf miniqmc .build*
