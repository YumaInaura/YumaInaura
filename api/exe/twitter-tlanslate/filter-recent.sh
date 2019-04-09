#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

USER_ID="473780756"
cat "$log_dir"/ja-timeline.json | OWN_USER_ID="$USER_ID" "$api_dir"/twitter/filter-own.py > "$log_dir"/ja-timeline-own.json

interval_second=${INTERVAL:-60}
start_unixtimestamp=$(($(date +%s)-$interval_second))

cat "$log_dir"/ja-timeline-own.json | \
  "$api_dir"/twitter/filter-timestamp.py "$start_unixtimestamp" | \
  tee "$log_dir"/ja-timeline-recent.json

