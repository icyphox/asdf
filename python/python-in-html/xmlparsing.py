import sys
from io import StringIO
import contextlib
import bs4

doc = open('test.html').read()
soup = bs4.BeautifulSoup(doc, 'lxml')

py = soup.find_all(id="#py")

@contextlib.contextmanager
def stdoutIO(stdout=None):
    old = sys.stdout
    if stdout is None:
        stdout = StringIO()
    sys.stdout = stdout
    yield stdout
    sys.stdout = old

out = []

for tag in py:
    with stdoutIO() as s:
        try:
            exec(tag.text)
        except:
            print('lmao that did not work')
    out.append(s.getvalue())

for o,p in zip(out, py):
    p.string.replace_with(o)

with open('test.html', 'w') as f:
    f.write(str(soup))

