import ospaths, os

var path = getCurrentDir()
var o = open(path)
echo o.readFile()
