#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
log_dir="$base_dir"/log

mkdir -p "$log_dir"

cat /dev/stdin \
  | \
    TOKEN=$(~/.secret/qiita-token)
    "$base_dir"/item-post-json.py \
  | tee "$log_dir"/item-posted.json

