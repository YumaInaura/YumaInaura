#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

source ~/.secret/env/twitter-yumainaura

if [ $((RANDOM)) -gt 3000 ]; then
  echo "no conitinue ja-en tweet  by random"
  exit
fi

cat "$log_dir"/ja-en-seed.json | \
  JSON_KEY="text" \
  "$api_dir"/twitter/create.py | \
  tee "$log_dir"/en-tweet-result.json

