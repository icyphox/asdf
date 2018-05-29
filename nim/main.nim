# nimshell: a simple shell written in Nim

proc main() =
  # load configs if any
  sh_loop();
  # cleanup and shutdown

proc sh_loop() =
  var line = ""
  var args = ""
  var status
  
  # do-while template
  template doWhile(a, b: untyped): untyped =
    b
    while a:
      b

  doWhile status:
    echo "> "
    line = sh_read_line()
    args = sh_split_line(line)
    status = sh_execute(args)

const SH_RL_BUFSIZE 1024
proc sh_read_line() =
  var bufsize = SH_RL_BUFSIZE
  var position = 0
  var buffer = 

