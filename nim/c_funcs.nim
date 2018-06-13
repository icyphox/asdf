proc strcmp(a, b: cstring): cint {.importc: "strcmp", nodecl.}
echo strcmp("abc", "def")
echo strcmp("kek", "kek")

proc printf(formatstr: cstring) {.header: "<stdio.h>", varargs.}

var x = "foo"
printf("Hello %d %s!\n", 19, x)
