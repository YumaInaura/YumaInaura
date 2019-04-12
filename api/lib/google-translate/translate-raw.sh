#!/usr/bin/env bash

base_dir=$(dirname "$0")

TOKEN=$("$base_dir"/get-token.sh) \
  "$base_dir"/translate.py | \
  jq -r '.data.translations[].translatedText'

