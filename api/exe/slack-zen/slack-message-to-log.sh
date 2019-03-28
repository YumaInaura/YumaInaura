#!/usr/bin/env bash

set -eu

# --------------------------------------
# PREPAIR
# --------------------------------------

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"

api_dir="${basedir}/../../lib"
log_dir="${basedir}"/log

channel_history_log_file="$log_dir"/slack-channel-history.json
message_log_file="$log_dir"/slack-message.json
user_message_log_file="$log_dir"/slack-user-message.json

mkdir -p "${log_dir}"
rm -rf "${log_dir}"/*

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')
github_title="いなうらゆうまはここにいた ${date}"

github_repository="playground"

# --------------------------------------

eval "${basedir}/channel-history.sh" > "$channel_history_log_file"

cat "$channel_history_log_file" | jq '.["messages"][]' > "$message_log_file"
cat "$message_log_file" | jq 'select(has("client_msg_id"))' > "$user_message_log_file"

user_slack_messages=$(cat "$user_message_log_file")

if [ "$user_slack_messages" == "[]" ] || [ -z "$user_slack_messages" ]; then
  echo No slack messages found
  exit
fi


