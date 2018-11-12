import strutils

type Fruit =
  enum Apple, Banana, Cherry


for i in 1 .. 10_000_000:
  var select = parseEnum[Fruit]("cherry")
  doAssert select == Cherry
