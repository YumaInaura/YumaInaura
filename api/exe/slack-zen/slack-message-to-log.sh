#!/usr/bin/env bash

set -eu

# --------------------------------------
# PREPAIR
# --------------------------------------

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

mkdir -p "${log_dir}"
rm -rf "${log_dir}"/*slack*

eval "${basedir}/channel-history.sh" | tee "$slack_channel_history_log_file" | jq .

cat "$slack_channel_history_log_file" | jq '.["messages"][]' | tee "$slack_message_log_file" | jq . 
cat "$slack_message_log_file" | jq 'select(has("client_msg_id"))' | tee "$slack_user_message_log_file" | jq .

user_slack_messages=$(cat "$slack_user_message_log_file")

if [ "$user_slack_messages" == "[]" ] || [ -z "$user_slack_messages" ]; then
  echo No slack messages found
  exit 1
fi

