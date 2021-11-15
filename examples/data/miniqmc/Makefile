RDY=$(findstring miniqmc,$(HPCTOOLKIT_EXAMPLE))

all: 
	@echo 
	@echo Specify one of the possible targets: 
	@echo "	download: build miniqmc data" 
	@echo "	view: use hpcviewer to inspect performance data for miniqmc"
	@echo "	clean: delete downloaded performance data"
	@echo

download:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_MINIQMC_DOWNLOAD)" \
	      	sh make-scripts/check.sh make-scripts/download.sh

view:
	@READY=$(RDY) CMD=sh DB="hpctoolkit-miniqmc-gpu-openmp" \
	      	sh make-scripts/check.sh make-scripts/view.sh

clean: 
	/bin/rm -rf tarfile hpctoolkit* 
