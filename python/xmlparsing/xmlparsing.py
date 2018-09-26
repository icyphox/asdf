from requests_html import HTML
import sys
from io import StringIO
import contextlib
import bs4

doc = open('test.html').read()
soup = bs4.BeautifulSoup(doc, "html.parser")

html = HTML(html=doc)
py = html.find('py') 

@contextlib.contextmanager
def stdoutIO(stdout=None):
    old = sys.stdout
    if stdout is None:
        stdout = StringIO()
    sys.stdout = stdout
    yield stdout
    sys.stdout = old

for tag in py:
    with stdoutIO() as s:
        try:
            exec(tag.text)
        except:
            print("uh your code is borked")

out = s.getvalue()

py_tag = soup.py
py_tag.string.replace_with(out)

print(py_tag.string)
