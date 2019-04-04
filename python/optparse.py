#!/usr/bin/env python3

import sys, json, pbm
from optparse import OptionParser

parser = OptionParser()

parser.add_option("-s", "--some", dest="some_option")
(options, args) = parser.parse_args()

print(options.some_option)

