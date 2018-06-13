#include "fib.h"
#include <stdio.h>

int main(void)
{
  NimMain();
  for (int f = 0; f < 10; f++)
    printf("Fib of %d is %d\n", f, fib(f));
  return 0;
}
