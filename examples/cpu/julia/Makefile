RDY=$(findstring julia,$(HPCTOOLKIT_EXAMPLE))

all:
	@echo ""
	@echo specify one of the possible targets: 
	@echo "	run: use hpctoolkit to measure and analyze a julia mb.jl"
	@echo " view: invoke hpcviewer to inspect results of measurement and analysis"
	@echo "	clean: remove build and performance data"
	@echo ""

run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_JULIA_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/run.sh

view:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_JULIA_VIEW)" \
                sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf julia* 
