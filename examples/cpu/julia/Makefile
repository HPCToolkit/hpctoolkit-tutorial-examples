RDY=$(findstring julia,$(HPCTOOLKIT_EXAMPLE))

all:
	@echo ""
	@echo specify one of the possible targets: 
	@echo "	run: use hpctoolkit to measure and analyze a julia mb.jl"
	@echo "	clean: remove build and performance data"
	@echo ""

run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_JULIA_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/run.sh

clean:
	/bin/rm -rf julia* 
