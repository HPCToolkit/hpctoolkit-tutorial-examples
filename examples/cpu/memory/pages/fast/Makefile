SUPPORT=../../../../../support
TCMALLOC_PATH=$(SUPPORT)/gperftools
TCMALLOC_ROOT=`pwd`/$(TCMALLOC_PATH)
TCMALLOC_LIBDIR=$(TCMALLOC_ROOT)/gperftools-install/lib


main: main.c $(TCMALLOC_PATH)/gperftools-install/lib/libtcmalloc_minimal.so
	gcc -o main -g main.c -L$(TCMALLOC_LIBDIR) -Wl,-rpath=$(TCMALLOC_LIBDIR) -ltcmalloc_minimal


run-time: main 
	rm -rf main-REALTIME main-REALTIME-database
	time hpcrun -e REALTIME -o main-REALTIME ./main
	hpcstruct main
	hpcprof -S main.hpcstruct -o main-REALTIME-database main-REALTIME
	hpcviewer main-REALTIME-database

run-cycles: main 
	rm -rf main-cycles main-cycles-database
	time hpcrun -e cycles -o main-cycles ./main
	hpcstruct main
	hpcprof -S main.hpcstruct -o main-cycles-database main-cycles
	hpcviewer main-cycles-database

run-pf: main 
	rm -rf main-cycles-faults main-cycles-faults-database
	time hpcrun -e cycles -e page-faults -o main-cycles-faults ./main
	hpcstruct main
	hpcprof -S main.hpcstruct -o main-cycles-faults-database main-cycles-faults
	hpcviewer main-cycles-faults-database

$(TCMALLOC_PATH):
		pushd $(SUPPORT); make

$(TCMALLOC_PATH)/gperftools-install/lib/libtcmalloc_minimal.so: $(TCMALLOC_PATH)
	-mkdir $(TCMALLOC_ROOT)/gperftools-build
	-mkdir $(TCMALLOC_ROOT)/gperftools-install
	(cd $(TCMALLOC_ROOT)/gperftools-build; ../configure --prefix=`pwd`/../gperftools-install; make -j install)

clean:
	/bin/rm -rf main main-* main.hpcstruct

