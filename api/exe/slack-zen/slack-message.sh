#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/prepare.sh"

interval_sec=${INTERVAL:-$slack_message_interval}
oldest_unixtime=$(($(date +%s) - $interval_sec))

TOKEN="$slack_token" \
CHANNEL="$slack_channel_id" \
OLDEST="$oldest_unixtime" \
  python "${base_dir}"/../../lib/slack/channel-message.py \
   | tee "$slack_channel_history_log_file"

cat "$slack_channel_history_log_file" | jq '.["messages"]' | tee "$slack_message_log_file" | jq .
cat "$slack_message_log_file" | jq 'map(select(.subtype == null))' | tee "$slack_user_message_log_file" | jq .
cat "$slack_user_message_log_file" | jq '.[].text' | sed -e 's/^"//g' | sed -e 's/"$//g' | tee "$slack_message_plain_log_file"

