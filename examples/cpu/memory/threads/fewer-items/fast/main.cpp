#include <stdlib.h>

#include <list>

#define NREPS 40000
#define N 1000



void
dowork()
{
  std::list<int> items;
  for (int i=0; i < N; i++) {
   items.push_back(i);
  }
  for (int i=0; i < N; i++) {
   items.pop_front();
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
