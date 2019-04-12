#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

mkdir -p "$log_dir"

source ~/.secret/env/twitter-yumainaura2nd

ALL=1 "$api_dir"/twitter/timeline.py |
  tee "$log_dir"/timeline-yumainaura-2nd.json

cat "$log_dir"/timeline-yumainaura-2nd.json | OWN_USER_ID=1095662627890425900 "$api_dir"/twitter/filter-own.py > "$log_dir"/timeline-own-tweet-yumainaura2nd.json
cat "$log_dir"/timeline-own-tweet-yumainaura2nd.json | "$api_dir"/twitter/jst-datetime-filter.py > "$log_dir"/timeline-jst-yesterday-yumainaura2nd.json
cat "$log_dir"/timeline-jst-yesterday-yumainaura2nd.json | PERIOD='\\.' "$api_dir"/twitter/markdown.py > "$log_dir"/yumainaura2nd.md

