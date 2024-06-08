RDY=$(findstring lulesh,$(HPCTOOLKIT_EXAMPLE))

all:
	@echo ""
	@echo specify one of the possible targets: 
	@echo "	build: build lulesh"
	@echo "	run: use hpctoolkit to collect measurements about the CPU performance of lulesh"
	@echo "	analyze: use hpcprof to analyze the performance of two runs for a scalability comparison"
	@echo "	view: invoke hpcviewer to inspect results of measurement and analysis"
	@echo "	clean: remove build and performance data"

build:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_BUILD)" \
	      	sh make-scripts/check.sh make-scripts/build.sh

run:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_RUN)" \
	      	sh make-scripts/check.sh make-scripts/lulesh.sh

analyze:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_ANALYZE)" \
	      	sh make-scripts/check.sh make-scripts/prof.sh

view:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_AMG2013_VIEW)" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean:
	/bin/rm -rf hpctoolkit* *core*
	/bin/rm -rf .build* log.*

veryclean: clean
	/bin/rm -rf lulesh
	$(CLEAN_CMD)
