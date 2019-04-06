#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

mkdir -p "$log_dir"

cp ~/.secret/twitter-yumainaura2nd-config.py "$api_dir"/twitter/config.py
ALL=1 "$api_dir"/twitter/timeline.py > "$log_dir"/timeline-yumainaura-2nd.json

cat "$log_dir"/timeline-yumainaura-2nd.json | OWN_USER_ID=1095662627890425900 "$api_dir"/twitter/filter-own.py > "$log_dir"/timeline-own-tweet-yumainaura2nd.json
cat "$log_dir"/timeline-own-tweet-yumainaura2nd.json | "$api_dir"/twitter/jst-datetime-filter.py > "$log_dir"/timeline-jst-yesterday-yumainaura2nd.json
cat "$log_dir"/timeline-jst-yesterday-yumainaura2nd.json | "$api_dir"/twitter/markdown.py > "$log_dir"/yumainaura2nd.md

