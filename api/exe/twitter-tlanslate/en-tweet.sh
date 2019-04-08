#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

cp ~/.secret/twitter-yumainaura2nd-config.py "$api_dir"/twitter/config.py

 echo "abc" | "$api_dir"/twitter/create.py
#for en_text in "$(cat "$log_dir"/en-text.log)"; do
# echo "$en_text" | "$api_dir"/twitter/create.py
#done

