all:
	@echo specify one of the possible targets: 
	@echo "	build: build lammps and its supporting code"
	@echo "	run:  use hpctoolkit to collect, analyze, and present information about gpu performance "
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	clean: remove performance data"
	@echo "	veryclean: remove build and performance data"

build:
	sh make-scripts/build.sh

run:
	sh make-scripts/run_hpcrun.sh

run-pc:
	sh make-scripts/run_hpcrun_pc.sh

clean:
	/bin/rm -rf hpctoolkit-* lmp.hpcstruct log.lammps

veryclean: clean
	/bin/rm -rf build lmp
