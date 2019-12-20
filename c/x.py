import struct
import socket

s = socket.socket()
s.connect(("127.0.0.1", 1337))
r = s.recv(1024)
print(r)
