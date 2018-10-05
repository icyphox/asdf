import unittest

suite "some description here":
  echo("suite setup running or whatever")

  setup:
    echo("runs before each test")

  teardown:
    echo("runs after each test")

  test "essential truths":
    require(true)

  test "slightly less obvious stuff":
    check(1 != 1)
    check("asd"[2] == 'd')

  test "out of bounds error should be thrown":
    let v = @[1, 2, 3]
    expect(IndexError):
      discard v[4]

    echo("suite teardown running")


