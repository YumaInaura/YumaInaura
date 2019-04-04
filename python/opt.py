#!/usr/bin/env python3

from optparse import OptionParser

parser = OptionParser()

parser.add_option("--some", dest="some_option")
(options, args) = parser.parse_args()

print(options.some_option)

