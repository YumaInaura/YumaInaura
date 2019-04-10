#!/usr/bin/env python3

import markdown2, sys

text = sys.stdin.read()

html_text = markdowner.convert(text)

print(html_text)


