#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

tweet_url="$1"
eval "$base_dir"/upstream-tweet-chain-by-timeline.py \
  | "$tweet_url" \
  > "$base_dir"/log/upstream-tweet-chain-by-timeline.json"

