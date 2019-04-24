#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

mkdir -p "$log_dir"
rm -rf "$log_dir"/*

source ~/.secret/env/twitter-yumainaura

ALL=1 "$api_dir"/twitter/timeline.py > "$log_dir"/timeline.json

cat "$log_dir"/timeline.json | \
  OWN_USER_ID="$TWITTER_JA_USER_ID" "$api_dir"/twitter/filter-own.py \
  > "$log_dir"/timeline-own-tweet.json

interval_second=${INTERVAL:-3600}
start_unixtimestamp=$(($(date +%s) - $((60)) - $interval_second))
end_unixtimestamp=$(($(date +%s) - $((60))))

cat "$log_dir"/timeline-own-tweet.json \
  | "$api_dir"/twitter/filter-timestamp.py "$start_unixtimestamp" "$end_unixtimestamp" \
  | tee "$log_dir"/timeline-recent.json

cat "$log_dir"/timeline-recent.json \
  | "$api_dir"/twitter/format-customed-mark.py \
  > "$log_dir"/timeline-format.json

tweet_border=10
if [ $(cat "$log_dir"/timeline-format.json | jq length) -lt $tweet_border ]; then
  echo Tweets num under "$tweet_border"
  exit 1
fi

cat "$log_dir"/timeline-format.json \
  | jq '[.[] | select(.in_reply_to_status_id == null)]' \
  | "$api_dir"/twitter/markdown.py \
  > "$log_dir"/"$TWITTER_JA_USER_NAME".md

cat "$log_dir"/timeline-format.json \
  | jq -r  '.[0].full_text' \
  | tr "\r\n" " " \
   > "$log_dir"/"$TWITTER_JA_USER_NAME"-issue-title.txt

