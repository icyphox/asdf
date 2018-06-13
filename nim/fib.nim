proc fib(a: cint): cint {.exportc.} =
  if a <= 2:
    result = 1
  else:
    result = fib(a - 1) + fib(a - 2)
