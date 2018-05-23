from strutils import parseInt
import system

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

for i in countup(1, 20):
  echo i

for index, item in ["a", "b"].pairs:
  echo item, " at index ", index

block:
  echo "this is a block"

block namedblock:
  echo "this is a named blok"

when system.hostOS == "windows":
  echo "spotted teh winfag"
elif system.hostOS == "linux":
  echo "aaah! the neckbeard"
else:
  echo "t. soyboy"
