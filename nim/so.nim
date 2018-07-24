proc nms_exec(s: cstring): cstring {.importc, dynlib: "/usr/local/lib/libnms.so".}

echo nmsExec("lmao")
