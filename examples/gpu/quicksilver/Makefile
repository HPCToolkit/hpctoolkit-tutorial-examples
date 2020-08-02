OPTFLAGS = -O2 -lineinfo -g

#version below for more accurate gpu source info, but no optimization
#OPTFLAGS = -g -G -O0

CXX = $(CUDA_HOME)/bin/nvcc  
CXXFLAGS = -DHAVE_CUDA -std=c++11 $(OPTFLAGS) -Xptxas -v -gencode=arch=compute_70,code=\\\"sm_70,compute_70\\\"
CXXFLAGS = -DHAVE_CUDA -std=c++11 $(OPTFLAGS) -gencode=arch=compute_70,code=\\\"sm_70,compute_70\\\"
CPPFLAGS = -x cu -dc
LDFLAGS= -L${CUDA_HOME}/lib64 -lcuda -lcudart

all:
	@echo specify one of the possible targets: 
	@echo "	build: build quicksilver"
	@echo "	run-pc: use hpctoolkit to collect, analyze, and present instruction-level information about gpu performance "
	@echo "	run: use hpctoolkit to collect, analyze, and present kernel-level information about gpu performance "
	@echo "	clean: remove performance data"
	@echo "	veryclean: remove build and performance data"

build:
	/bin/rm -rf quicksilver
	time sh build.sh

build-quicksilver:
	make -j -C quicksilver/src CXX="$(CXX)" CXXFLAGS="$(CXXFLAGS)" CUDA_LDFLAGS="$(CUDA_LDFLAGS)" CPPFLAGS="$(CPPFLAGS)" LDFLAGS="$(CUDA_LDFLAGS)"

run-pc:
	time sh run_hpcrun_pc.sh

run:
	time sh run_hpcrun.sh

clean:
	/bin/rm -rf hpctoolkit* *.hpcstruct quicksilver qs
