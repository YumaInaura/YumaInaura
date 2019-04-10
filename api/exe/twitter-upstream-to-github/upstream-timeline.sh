#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

log_dir="$base_dir"/log
mkdir -p "$log_dir"

tweet_url="$1"

eval "$api_dir"/twitter/upstream-tweet-chain-by-timeline.py "$tweet_url" \
  > "$log_dir"/upstream-tweet-chain-by-timeline.json

