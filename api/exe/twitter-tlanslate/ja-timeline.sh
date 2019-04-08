#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

mkdir -p "$log_dir"

cp ~/.secret/twitter-yumainaura-config.py "$api_dir"/twitter/config.py
ALL=1 ROUND=1 "$api_dir"/twitter/timeline.py > "$log_dir"/ja-timeline.json

cat "$log_dir"/ja-timeline.json | "$api_dir"/

