#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source ${basedir}/../../setting.sh
source ${basedir}/prepare.sh

interval_sec=${INTERVAL:-60}
oldest_unixtime=$(($(date +%s) - $interval_sec))

slack_channel_history=$(
  TOKEN="$slack_token" \
  CHANNEL="$slack_channel_id" \
  OLDEST="$oldest_unixtime" \
  python "${basedir}"/../../lib/slack/channel-message.py
)

echo "$slack_channel_history" 

