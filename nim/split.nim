import rdstdin, strutils, osproc

try:
  while true:
    var lel = readLineFromStdin("> ")
    var args = lel.splitWhitespace()
    var p = startProcess(args[0], "", @["ls"])

except IOError:
  echo "Bye!"
