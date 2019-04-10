#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
log_dir="$base_dir"/log

mkdir -p "$log_dir"

tweet_url="$1"

eval "$base_dir"/../upstream-tweet-chain-by-timeline.py "$tweet_url" \
  > "$log_dir"/upstream-tweet-chain-by-timeline.json

