main: main.cpp
	g++ -o main -g -fopenmp main.cpp

run-cycles: main 
	time hpcrun -e cycles -o main-cycles ./main
	hpcstruct main
	hpcprof -S main.hpcstruct -o main-cycles-database main-cycles
	hpcviewer main-cycles-database


run-time: main 
	time hpcrun -e REALTIME -o main-REALTIME ./main
	hpcstruct main
	hpcprof -S main.hpcstruct -o main-REALTIME-database main-REALTIME
	hpcviewer main-REALTIME-database

clean:
	/bin/rm -rf main main-* main.hpcstruct

