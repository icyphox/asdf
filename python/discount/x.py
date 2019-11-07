from ctypes import *

lm = CDLL("./libmarkdown.so")

with open("./test.md") as f:
    p = create_string_buffer(bytes(f.read(), "UTF-8"))

doc = lm.mkd_string(p, sizeof(p))
print(doc)
