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

eval "${basedir}/slack-channel-history.sh" | tee "$slack_channel_history_log_file" | jq .

cat "$slack_channel_history_log_file" | jq '.["messages"][]' | tee "$slack_message_log_file" | jq .
cat "$slack_message_log_file" | jq 'select(has("client_msg_id"))' | tee "$slack_user_message_log_file" | jq .
cat "$slack_user_message_log_file" | jq '.text' | sed -e 's/^"//g' | sed -e 's/"$//g' | tee "$slack_message_plain_log_file"

