echo "\e[1;9;32mBold!\e[0m " & "\e[36mCyan!"
import terminal

proc blue(s: string): string =
  setForegroundColor(fgBlue)
  result = s

proc red(s: string): string =
  setForegroundColor(fgRed)
  result = s


echo blue("kek") & red("ek")
