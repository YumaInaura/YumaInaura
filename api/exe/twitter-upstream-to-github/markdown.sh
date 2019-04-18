#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

log_dir="$base_dir"/log

cat "$log_dir"/upstream-tweets.json \
  | jq --raw-output '.[0].full_text' \
  | tee "$log_dir"/github-title.txt

cat "$log_dir"/upstream-tweets.json \
  | jq reverse \
  | "$api_dir"/twitter/format-customed-mark.py \
  | "$api_dir"/twitter/markdown.py \
  | tee "$log_dir"/github-body.md


