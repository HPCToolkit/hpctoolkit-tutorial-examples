all:
	@echo specify one of the possible targets: 
	@echo "	build: build lammps and its supporting code"
	@echo "	run:  use hpctoolkit to collect, analyze, and present information about gpu performance "
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "

build:
	sh build.sh

run:
	sh run_hpcrun.sh

run-pc:
	sh run_hpcrun_pc.sh

clean:
	/bin/rm -rf hpctoolkit-* lmp.hpcstruct log.lammps

veryclean: clean
	/bin/rm -rf build lammps
