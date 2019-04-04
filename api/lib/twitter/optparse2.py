#!/usr/bin/env python3

import sys, json, pbm
from optparse import OptionParser

parser = OptionParser()

parser.add_option("-e", "--end-with", dest="end_with")
(options, args) = parser.parse_args()

print(options.end_with)
exit()

