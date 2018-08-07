import net

var server = newSocket()
server.bindAddr(Port(2222))
server.listen()

var client = new Socket
server.accept(client)

echo(client.recvLine())

