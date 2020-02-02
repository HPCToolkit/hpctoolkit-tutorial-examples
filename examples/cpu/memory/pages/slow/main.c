#include <stdlib.h>

#define NREPS 250
#define N 100000000

void
dowork()
{
  int i;
  int *worktmp = malloc(N * sizeof(int));
  for (i=0; i<N; i+=4096) {
    worktmp[i] = 10;
  }
  free(worktmp);
}

int 
main(int argc, char **argv)
{
  int reps;
  dowork();
  for (reps=0; reps < NREPS; reps++) { 
    dowork();
  }
}
