#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

source ~/.secret/env/twitter-yumainaura2nd

cat "$log_dir"/en-seed.json | \
  JSON_KEY="text" \
  MAX_LENGTH=500 \
    "$api_dir"/twitter/create.py | \
  tee "$log_dir"/en-tweet-result.json

