#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

mkdir -p "$log_dir"
rm -rf "$log_dir"/*

cat "$log_dir"/tags.json | \
  jq '[ .[] | select(.id | match("^[a-zA-z][a-zA-z0-9]+$")) ]' \
  | tee "$log_dir"/english-tags.json

