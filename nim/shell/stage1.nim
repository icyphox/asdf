# fork, exec, wait
import posix
import strutils
import os
import sequtils

proc handler() {.noconv.} =
  stdout.write("\n$ ")
  stdout.flushFile()

var 
  status: cint
  pid: Pid
  wpid: Pid
  line: cstringArray

while true:
  setControlChook(handler)
  stdout.write("$ ")
  stdout.flushFile()
  try:
    line = stdin.readLine.splitWhitespace.allocCStringArray
    pid = fork()
    if pid == 0:
      if line[0] == "\n":
        line[0] = "\0"
      status = execvp(line[0], line)
    elif pid < 0:
      stdout.write("error in fork()ing")
    else:
      wpid = waitpid(pid, status, WUNTRACED)
    line.deallocCStringArray
  except EOFError:
    quit 0
