import math

proc summer*(x, y: int): int {.exportc, dynlib.} =
  result = x + y


