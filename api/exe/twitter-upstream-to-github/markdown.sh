#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

log_dir="$base_dir"/log

cat "$log_dir"/timeline.json \
  | jq reverse \
  | "$api_dir"/twitter/markdown.py \
  > "$log_dir"/github-body.md

