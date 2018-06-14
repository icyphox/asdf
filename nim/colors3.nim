import terminal

stdout.setForegroundColor(fgRed)
stdout.write("I'm in red! ")
stdout.setForegroundColor(fgGreen)
stdout.write("But I'm in green!")
stdout.resetAttributes()
stdout.write("\n")
echo "Look, I'm not colored!"

setForegroundColor(fgBlue)
echo "blue"
setForegroundColor(fgGreen)
echo "green"
