
{.compile: "logic.c".}
proc addtwoints(a, b: cint): cint {.importc.}

when isMainModule:
  echo addtwoints(3, 7)
