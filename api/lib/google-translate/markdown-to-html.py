#!/usr/bin/env python3

import sys
from markdown2 import Markdown

text = sys.stdin.read()

markdowner = Markdown()

html_text = markdowner.convert(text)

print(html_text)


