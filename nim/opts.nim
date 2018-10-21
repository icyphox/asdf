import parseopt

proc writeHelp() =
  echo "help"

for kind, key, val in getOpt():
  case kind
  of cmdArgument:
    echo("hm")
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h": writeHelp()
  of cmdEnd: assert(false)
