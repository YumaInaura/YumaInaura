#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

mkdir -p "$log_dir"

cp ~/.secret/twitter-yumainaura-config.py "$api_dir"/twitter/config.py
ALL=1 "$api_dir"/twitter/timeline.py > "$log_dir"/timeline.json

cp ~/.secret/twitter-yumainaura2nd-config.py "$api_dir"/twitter/config.py
