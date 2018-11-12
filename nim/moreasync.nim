import nanoid, asyncdispatch, asyncnet

type User = object
  name: string
  id: string

proc createUser() {.async.} =
  var u: User
  u.name = await generate("abcdef", 7)
  u.id = await generate("1234567890", 8)
