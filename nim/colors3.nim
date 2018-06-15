import terminal
import typetraits

setForegroundColor(fgRed)
echo "I'm in red! "
setForegroundColor(fgGreen)
echo "But I'm in green!"
stdout.resetAttributes()
stdout.write("\n")
echo "Look, I'm not colored!"

setForegroundColor(fgBlue)
echo "blue"
setForegroundColor(fgGreen)
echo "green"
echo stdout.type.name
