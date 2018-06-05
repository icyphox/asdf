import math

proc prime(n: int): int =
  var n: int = 0
  var prime: bool
  for i in 2 .. n:
    prime = true
    for j in 2 ..< i:
      if i mod j == 0:
        prime = false
        break
    if prime:
      n = n + i
  return n

echo prime(10)
