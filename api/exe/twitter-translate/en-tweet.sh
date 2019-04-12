#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

source ~/.secret/env/twitter-yumainaura2nd

cat "$log_dir"/en-seed.json | \
  JSON_KEY="text" \
    "$api_dir"/twitter/create.py \
    | tee "$log_dir"/en-tweet-result.json

