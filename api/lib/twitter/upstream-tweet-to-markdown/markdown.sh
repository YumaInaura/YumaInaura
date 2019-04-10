#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
log_dir="$base_dir"/log

cat "$log_dir"/upstream-tweet-chain-by-timeline.json \
  "$base_dir"/../markdown.py \
  > "$log_dir"/markdown.txt

