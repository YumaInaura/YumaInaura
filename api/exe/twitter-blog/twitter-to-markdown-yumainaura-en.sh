#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

mkdir -p "$log_dir"

source ~/.secret/env/twitter-yumainaura

ALL=1 "$api_dir"/twitter/timeline.py > "$log_dir"/timeline.json

"$api_dir"/twitter/user-show.sh "$TWITTER_JA_USER_NAME" \
  | tee "$log_dir"/yumainaura-user-profile.json

cat "$log_dir"/timeline.json | \
  OWN_USER_ID="$TWITTER_JA_USER_ID" \
    "$api_dir"/twitter/filter-own.py \
  | jq '[.[] | select(.lang == "en")]' \
  > "$log_dir"/timeline-own-tweet.json

cat "$log_dir"/timeline-own-tweet.json | \
  "$api_dir"/twitter/jst-datetime-filter.py \
  > "$log_dir"/timeline-jst-yesterday.json

cat "$log_dir"/timeline-jst-yesterday.json | \
  "$api_dir"/twitter/format-customed-mark.py \
  > "$log_dir"/timeline-format.json

cat "$log_dir"/timeline-format.json \
  | "$api_dir"/twitter/markdown.py \
  | tee "$log_dir"/"$TWITTER_JA_USER_NAME"-en.md

