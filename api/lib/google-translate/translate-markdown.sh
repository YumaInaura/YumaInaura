#!/usr/bin/env bash

base_dir=$(dirname "$0")

log_dir="$base_dir"/log
 
mkdir -p "$log_dir"

cat /dev/stdin \
  | redcarpet --parse=fenced_code_blocks \
  tee "$log_dir"/seed.html

cat "$log_dir"/seed.html \
  | FORMAT=html ./translate.sh \
  | tee "$log_dir"/translated.html

cat "$log_dir"/translated.html \
  | jq . --raw-output \
  | reverse_markdown \
  | tee "$log_dir"/translated.md


