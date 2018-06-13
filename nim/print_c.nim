{.compile: "print.c".}
proc print(s: cstring): cint {.importc.}

when isMainModule:
  echo print("lol")
