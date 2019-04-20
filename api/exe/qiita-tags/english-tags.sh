#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/tags.json | \
  jq '[ .[] | select(.id | match("^[a-za-z][a-za-z0-9]+$")) ]' \
  | tee "$log_dir"/english-tags.json

cat "$log_dir"/tags.json | \
  jq '[ .[0:1000] | .[] | select(.id | match("^[a-zA-z][a-zA-z0-9]+$")) ]' \
  | tee "$log_dir"/english-top-tags.json

