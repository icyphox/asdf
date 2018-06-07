import net

var socket= newSocket()
socket.connect("google.com", Port(80))

echo socket.recv(500)
