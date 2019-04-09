#!/usr/bin/env bash

basedir=$(dirname "$0")

TOKEN=$("$basedir"/get-token.sh) \
  python "$basedir"/translate.py | \
  jq '.data.translations[].translatedText'


