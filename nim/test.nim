type MyType = object
  discard

template toSeq(iter: untyped): untyped =
  var result: type(iter) = 1

iterator foo(a: MyType): int =
  discard

const v = MyType()

toSeq(v.foo)
