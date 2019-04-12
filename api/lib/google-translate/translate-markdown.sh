#!/usr/bin/env bash

base_dir=$(dirname "$0")

log_dir="$base_dir"/log
 
mkdir -p "$log_dir"

cat /dev/stdin \
  | redcarpet --parse=fenced_code_blocks \
  | tee "$log_dir"/seed.html

cat "$log_dir"/seed.html \
  | perl -pe 's/\n/<br>/g' \
  | tee "$log_dir"/seed-formatted.html

cat "$log_dir"/seed-formatted.html \
  | FORMAT=html ./translate.sh \
  | tee "$log_dir"/translated.html

cat "$log_dir"/translated.html \
  | jq . --raw-output \
  | perl -pe 's/<br>/\n/g' \
  | tee "$log_dir"/translated-reverted.html

cat "$log_dir"/translated-reverted.html \
  | reverse_markdown \
  | tee "$log_dir"/translated.md

