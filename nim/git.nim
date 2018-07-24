proc git_libgit2_init(): cint {.importc, dynlib: "/usr/local/lib/libgit2.so".}

git_libgit2_init()
echo "initialized repo i think"
