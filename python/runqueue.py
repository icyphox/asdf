class Runqueue:
    def __init__(self):
        from collections import deque
        self.queue = deque()

    def add(self, fn, *args, **kwargs):
        g = fn(*args, **kwargs)
        self.queue.append(g)

    def schedule(self):
        while self.queue:
            task = self.queue[0]
            try:
                next(task)
            except StopIteration:
                self.queue.popleft()
            else:
                self.queue.rotate(-1)

def foo():
    for i in range(10):
        print("in foo():", i)
        yield

def bar():
    for i in range(5):
        print("in bar():", i)
        yield

if __name__ == "__main__":
    rq = Runqueue()
    rq.add(foo)
    rq.add(bar)
    rq.schedule()
