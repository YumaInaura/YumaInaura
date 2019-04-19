#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
log_dir="$base_dir"/log

mkdir -p "$log_dir"

for page in {1..100}; do
  curl -s "https://qiita.com/api/v2/tags?page=${page}&per_page=100&sort=count" | jq '.[].id';
  sleep 5
done | tee "$log_dir"/qiita-tag.txt

