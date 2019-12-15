proc printf(format: cstring): cint {.importc, varargs, header: "stdio.h", discardable.}
printf("hi %s", "lmao")

