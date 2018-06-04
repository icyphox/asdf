import typetraits

var lel: string = "lle"
var i: int = 1

proc kek(): bool =
  if lel.type.name == "string" and 
   i.type.name == "int":
    return true
  else:
    return false

echo kek()

