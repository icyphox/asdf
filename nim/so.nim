proc nms_exec(s: cstring): cstring {.importc, dynlib: "/usr/local/lib/libnms.so".}
proc nms_set_auto_decrypt(i: cint) {.importc, dynlib: "/usr/local/lib/libnms.so".}
proc nms_set_foreground_color(s: cstring) {.importc, dynlib: "/usr/local/lib/libnms.so".}


nms_set_foreground_color("green")
nms_set_auto_decrypt(1)
echo nms_exec("auto decrypiting")
