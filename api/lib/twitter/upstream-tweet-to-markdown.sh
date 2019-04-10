#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

tweet_url="$1"
eval "$basedir"/upstream-tweet-chain-by-timeline.py \
  | "$tweet_url" \
  > "$basedir"/log/upstream-tweet-chain-by-timeline.json"

