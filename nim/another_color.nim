import terminal
import std/colors

const Nim = "Efficient and expressive programming. And cool colors!"

var
  fg = colBrown
  bg = colBlue
  int = 1.0

enableTrueColors()
for i in 1..15:
  styledEcho bgColor, bg, fgColor, fg, Nim, resetStyle
  int -= 0.001
  fg = intensity(fg, int)

setForegroundColor colRed
setBackgroundColor colGreen
styledEcho "Hi!", resetStyle

disableTrueColors()
