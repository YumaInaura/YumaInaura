#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

cat "$log_dir"/ja-timeline.json \
  | jq '[.[] | select(.source | contains("yumainaura") | not) ]' \
  | tee "$log_dir"/ja-timeline-filter-api-resource.json

