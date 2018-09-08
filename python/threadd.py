from threading import Thread
from itertools import count

def foo():
    for i in range(10):
        print("in foo():", i)

def bar():
    for i in range(5):
        print("in bar():", i)

if __name__ == "__main__":
    t1 = Thread(target=foo)
    t2 = Thread(target=bar)
    t1.start()
    t2.start()
