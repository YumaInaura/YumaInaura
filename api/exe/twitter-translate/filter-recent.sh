#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

interval_second=${INTERVAL:-60}
start_unixtimestamp=$(($(date +%s)-$interval_second))

cat "$log_dir"/ja-timeline-own.json | \
  "$api_dir"/twitter/filter-timestamp.py "$start_unixtimestamp" | \
  tee "$log_dir"/ja-timeline-recent.json

