from strutils import parseInt
echo "What's your name? "
const 
  x = 1
  y = 3
  z = y + 5
echo z

if z == 10:
  echo "nyet"
else:
  echo "OmegaLUL"
try:
  let num = parseInt(readLine(stdin))
  case num
  of 0..2, 4..7: echo "hip"
  of 3, 8: echo "not hip"
  else: discard
except ValueError:
  echo "enter a num"

echo "What's your name"
var name = readLine(stdin)
while name == "":
  echo "Your name is empty"
  name = readLine(stdin)
