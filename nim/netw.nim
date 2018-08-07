import net

var socket = newSocket()
socket.bindAddr(Port(1234))
socket.listen()

var client = new Socket
var address = ""

while true:
  socket.acceptAddr(client, address)
  echo("Client connected from: ", address)
  client.close()
