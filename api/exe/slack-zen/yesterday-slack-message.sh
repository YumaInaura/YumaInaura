#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

interval_sec=${INTERVAL:-$slack_message_interval}
oldest_unixtime=$(($(date +%s) - $interval_sec))

today_ts=$(DATE=$(date +'%Y-%m-%d') "$api_dir"/jst-unixtimestamp.py)
yesterday_ts=$(DATE=$(date --date="1 days ago" +'%Y-%m-%d') "$apir_di"/jst-unixtimestaump.py)

TOKEN="$slack_token" \
CHANNEL="$slack_channel_id" \
OLDEST="$today_ts" \
LATEST="$yesterday_ts" \
  python "${basedir}"/../../lib/slack/channel-message.py \
   | tee "$slack_channel_history_log_file"

cat "$slack_channel_history_log_file" | jq '.["messages"]' | tee "$slack_message_log_file" | jq .
cat "$slack_message_log_file" | jq 'map(select(.subtype == null))' | tee "$slack_user_message_log_file" | jq .
cat "$slack_user_message_log_file" | jq '.[].text' | sed -e 's/^"//g' | sed -e 's/"$//g' | tee "$slack_message_plain_log_file"

