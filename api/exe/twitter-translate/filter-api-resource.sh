#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

cat "$log_dir"/ja-timeline.json \
  | jq '[.[] | select(.source | contains("yumainaura") | not) ]' \
  | tee "$log_dir"/ja-timeline-filter-api-resource.json

