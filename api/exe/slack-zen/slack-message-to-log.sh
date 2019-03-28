#!/usr/bin/env bash

set -eu

# --------------------------------------
# PREPAIR
# --------------------------------------

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"

api_dir="${basedir}/../../lib"
log_dir="${basedir}"/log

mkdir -p "${log_dir}"

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')
github_title="いなうらゆうまはここにいた ${date}"

github_repository="playground"

# --------------------------------------

eval "${basedir}/channel-history.sh" > "$log_dir"/channel-message.json

cat "$log_dir"/channel-message.json | jq '.["messages"][]' > "$log_dir"/slack-message.json
cat "$log_dir"/slack-message.json | jq 'select(has("client_msg_id"))' > "$log_dir"/user-slack-message.json

user_slack_messages=$(cat "$log_dir"/user-slack-message.json)

if [ "$user_slack_messages" == "[]" ] || [ -z "$user_slack_messages" ]; then
  echo No slack messages found
  exit
fi


