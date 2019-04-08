#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

mkdir -p "$log_dir"

interval_second=${INTERVAL:-60}

cp ~/.secret/twitter-yumainaura-config.py "$api_dir"/twitter/config.py
ALL=1 ROUND=1 "$api_dir"/twitter/timeline.py > "$log_dir"/ja-timeline.json

start_unixtimestamp=$(($(date +%s)-$interval_second))
cat "$log_dir"/ja-timeline.json | "$api_dir"/twitter/filter-timestamp.py "$start_unixtimestamp"

