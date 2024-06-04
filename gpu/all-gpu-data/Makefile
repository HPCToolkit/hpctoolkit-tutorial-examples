RDY=$(findstring allgpu,$(HPCTOOLKIT_EXAMPLE))

all: 
	@echo 
	@echo Specify one of the possible targets: 
	@echo "	download: build miniqmc data" 
	@echo "	clean: delete downloaded performance data"
	@echo

download:
	@READY=$(RDY) CMD="$(HPCTOOLKIT_ALLGPU_DOWNLOAD)" \
	      	sh make-scripts/check.sh make-scripts/download.sh

clean: 
	/bin/rm -rf tarfile hpctoolkit* 

distclean veryclean: clean
