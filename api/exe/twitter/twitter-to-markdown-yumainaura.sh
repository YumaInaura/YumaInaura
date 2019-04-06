#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

mkdir -p "$log_dir"

cp ~/.secret/twitter-yumainaura-config.py "$api_dir"/twitter/config.py
ALL=1 "$api_dir"/twitter/timeline.py > "$log_dir"/timeline.json

cat "$log_dir"/timeline.json | OWN_USER_ID=473780756 "$api_dir"/twitter/filter-own.py > "$log_dir"/timeline-own-tweet.json
cat "$log_dir"/timeline-own-tweet.json | "$api_dir"/twitter/jst-datetime-filter.py > "$log_dir"/timeline-jst-yesterday.json
cat "$log_dir"/timeline-jst-yesterday.json | "$api_dir"/twitter/markdown.py > "$log_dir"/yumainaura.md

