#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

cp ~/.secret/twitter-yumainaura2nd-config.py "$api_dir"/twitter/config.py

cat "$log_dir"/en-translated.json | \
  JSON_KEY="translated_text" \
  MAX_LENGTH=280 \
    "$api_dir"/twitter/create.py | \
  tee "$log_dir"/en-tweet-result.json

