import asyncdispatch, os

proc hello() {.async.} =
  echo "hello"

waitFor hello()

type Obj = object
  limit: int

iterator items(self: Obj): int =
  for i in 0..self.limit:
    sleep 5
    yield i

proc asyncFn() {.async.} =
  for i in Obj(limit: 9):
    echo i

proc anotherAsync() {.async.} =
  var remaining = 9
  while true:
    echo remaining
    dec remaining
    if not (remaining > 0):
      break
    await sleepAsync(1000)

waitFor anotherAsync()

