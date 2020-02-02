main: main.c
	gcc -o main -g main.c

run-time: main 
	time hpcrun -e REALTIME -o main-REALTIME ./main
	hpcstruct main
	hpcprof -S main.hpcstruct -o main-REALTIME-database main-REALTIME
	hpcviewer main-REALTIME-database

run-cycles: main 
	time hpcrun -e cycles -o main-cycles ./main
	hpcstruct main
	hpcprof -S main.hpcstruct -o main-cycles-database main-cycles
	hpcviewer main-cycles-database

run-pf: main 
	time hpcrun -e cycles -e page-faults -o main-cycles-faults ./main
	hpcstruct main
	hpcprof -S main.hpcstruct -o main-cycles-faults-database main-cycles-faults
	hpcviewer main-cycles-faults-database

clean:
	/bin/rm -rf main main-* main.hpcstruct

