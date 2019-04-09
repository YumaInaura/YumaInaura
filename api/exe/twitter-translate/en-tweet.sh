#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

cat "$log_dir"/en-translated.json | \
  jq ' "https://twitter.com/YumaInaura/status/" +  .[].id_str + " " + .[].translated_text' | \
  jq '[{ "text" : . }]' | \
  tee "$log_dir"/en-tweet.json

cp ~/.secret/twitter-yumainaura2nd-config.py "$api_dir"/twitter/config.py

cat "$log_dir"/en-tweet.json | \
  JSON_KEY="text" \
  MAX_LENGTH=280 \
    "$api_dir"/twitter/create.py | \
  tee "$log_dir"/en-tweet-result.json

