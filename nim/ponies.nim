# ponies.nim
# my zsh prompt with ponies!
# using @icyphox's nicy prompt
# Petr Grulich (@grulich)

import nicy, strformat

let
  prompt = color("› ", "magenta")
  nl = "\n"
  gitBranch = color(gitBranch(), "yellow")
  cwd = color(tilde(getCwd()), "cyan")
  dirty = color("no pony", "red")
  clean = color("pony", "green")
  g = gitBranch & gitStatus(dirty, clean)
  git = italics(g)
  venv = color(virtualenv(), "red")


# the prompt
echo fmt"{nl}{venv}{cwd}{git}{nl}{prompt}"
echo fmt"flag here! 53a2809b826c5d1d1da2eec4e6037a9a"
