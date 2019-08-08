#!/usr/bin/env python3
# generate an rss item

import html
from markdown2 import markdown_path
import sys
import datetime
import os
import jinja2
from collections import namedtuple

#try:
#    mdfile = sys.argv[1]
#except IndexError:
#    print('error: specify path to markdown file')
#    sys.exit(-1)
#url =  os.path.splitext(mdfile)[0]
#rendered = markdown_path(mdfile, extras=['metadata',
#        'fenced-code-blocks', 'header-ids', 'footnotes', 'smarty-pants'])
#meta = rendered.metadata
#esc = html.escape(rendered)

items_raw = []

for f in os.listdir('pages/blog'):
    if f != '_index.md':
        rendered = markdown_path('pages/blog/'+f, extras=['metadata',
            'fenced-code-blocks', 'header-ids', 'footnotes', 'smarty-pants'])
        items_raw.append(rendered) 

items = sorted(items_raw, key = lambda x: x.metadata['date'], reverse=True)
for i in items:
    print(i.metadata)


# jinja2
tl = jinja2.FileSystemLoader('./')
env = jinja2.Environment(loader=tl)
template = env.get_template('feed.xml.jinja2')
out = template.render(posts=items)

time stuff
dt = datetime.datetime.strptime(meta['date'], '%Y-%m-%d').date()
rfc822 = dt.strftime("%a, %d %b %Y %H:%M:%S %z") + '+0000'
#
#item = f"""<item>
#      <title>{meta['title']}</title>
#      <link>https://icyphox.sh/blog/{url}</link>
#      <description>{esc}</description>
#      <pubDate>{rfc822}</pubDate>
#      <guid>https://icyphox.sh/blog/{url}/</guid>
#</item>
#"""

#print(item)
