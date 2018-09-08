from threading import Thread
from time import sleep
from itertools import count

def foo():
    sleep(60)


for i in count():
    print(f"creating {i} thread")
    Thread(target=foo).start()
