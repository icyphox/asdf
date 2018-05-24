proc yes(question: string): bool = 
  echo question, " y/n"
  while true:
    case readLine(stdin)
    of "y", "Y": return true
    of "n", "N": return false
    else: echo "y/n or Y/N, get that right you numbskull"

if yes("Should I delete all your important files?"):
  echo "I'm sorry Dave, I can't do taht."
else:
  echo "I think you know what the problem is just as well as I do."
