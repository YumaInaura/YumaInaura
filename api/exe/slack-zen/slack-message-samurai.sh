#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

mkdir -p "${log_dir}"
rm -rf "${log_dir}"/*slack*

interval_sec=${INTERVAL:-60}
oldest_unixtime=$(($(date +%s) - $interval_sec))

TOKEN="$slack_token" \
CHANNEL="$slack_channel_id" \
OLDEST="$oldest_unixtime" \
  python "${basedir}"/../../lib/slack/channel-message.py \
   | tee "$slack_channel_history_log_file"

cat "$slack_channel_history_log_file" | jq '.["messages"][]' | tee "$slack_message_log_file" | jq .
cat "$slack_message_log_file" | jq 'select(.subtype == null)' | tee "$slack_user_message_log_file" | jq .
cat "$slack_user_message_log_file" | jq '.text' | sed -e 's/^"//g' | sed -e 's/"$//g' | tee "$slack_message_plain_log_file"

