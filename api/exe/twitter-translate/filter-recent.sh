#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

interval_second=${INTERVAL:-60}

start_unixtimestamp=$(($(date +%s) - $((9*60*60)) - $interval_second))
end_unixtimestamp=$(($(date +%s) - $((9*60*60))))

cat "$log_dir"/ja-timeline-own.json | \
  "$api_dir"/twitter/filter-timestamp.py "$start_unixtimestamp" "$end_unixtimestamp" | \
  tee "$log_dir"/ja-timeline-recent.json

