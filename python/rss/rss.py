#!/usr/bin/env python3
# generate an rss item

import html
from markdown2 import markdown
import sys
import os
import re
import arrow
import operator
import warnings

warnings.simplefilter("ignore", arrow.factory.ArrowParseWarning)
items_raw = []
import xml.etree.ElementTree as ET


def convert_date(d):
    return arrow.get(d, "YYYY-MM-DD").format("ddd, DD MMM YYYY HH:mm:ss Z")


PREFIX_URL = "https://icyphox.sh/blog/"


def generate_node(path):
    with open(path) as f:
        rendered = markdown(
            f.read(),
            extras=[
                "metadata",
                "fenced-code-blocks",
                "header-ids",
                "footnotes",
                "smarty-pants",
            ],
        )

        item = ET.Element("item")
        title = ET.SubElement(item, "title")
        title.text = rendered.metadata["title"]
        description = ET.SubElement(item, "description")
        description.text = rendered
        link_extractor = re.compile("\/([^\/]*)\.md$")
        link = ET.SubElement(item, "link")
        link.text = PREFIX_URL + link_extractor.search(path).group(1)
        pubData = ET.SubElement(item, "pubDate")
        pubData.text = convert_date(rendered.metadata["date"])

        # TODO: guid

        return item


def parse_article(path):
    with open(path) as f:
        rendered = markdown(
            f.read(),
            extras=[
                "metadata",
                "fenced-code-blocks",
                "header-ids",
                "footnotes",
                "smarty-pants",
            ],
        )
        return (arrow.get(rendered.metadata["date"]), path)


tree = ET.parse("feed.xml.jinja2")
articles = []

for f in os.listdir("pages/blog/"):
    if f != "_index.md":
        articles.append(parse_article(os.path.join("pages/blog", f)))

articles.sort(key=operator.itemgetter(0), reverse=True)

chan = tree.find("channel")

for article in articles:
    chan.append(generate_node(article[1]))

ET.dump(tree)

