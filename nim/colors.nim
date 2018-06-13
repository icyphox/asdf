import terminal, strformat

proc blue(s: string): string =
  setForegroundColor(fgBlue)
  result = s

proc green(s: string): string =
  setForegroundColor(fgGreen)
  result = s

when isMainModule:
  var greent = green("green")
  echo blue("hey this is blue")
  echo green("hey this is green")
  echo fmt"formatting in {greent}"
