#include <stdlib.h>

#include <list>

#define NREPS 5
#define N 1000000



void
dowork()
{
  std::list<int> items;
  for (int i=0; i < N; i++) {
   items.push_back(i);
  }
}

int 
main(int argc, char **argv)
{
  dowork();
#pragma omp parallel
  {
    for (int i = 0; i < NREPS; i++)
      dowork();
  }
}
