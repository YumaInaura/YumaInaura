#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

log_dir="$base_dir"/log
mkdir -p "$log_dir"

tweet_id=$(cat "$log_dir"/own-favorite-tweet-id.log)

eval "$api_dir"/twitter/upstream-tweet-chain.py "$tweet_id" \
  | tee "$log_dir"/upstream-tweets.json

