var test = @["set", "get", "flush"]

var cmd = @["get", "keyhere", "valuehere"]

for a in test:
  if a == cmd[0]:
    case cmd[0]
    of "set": echo "set"
    of "get": echo "get"
    of "flush": echo "flush"
    else: discard
  else:
    echo "no"
