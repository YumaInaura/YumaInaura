#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source ${basedir}/../../setting.sh

default_interval_sec=$(($(date +%s) - 60))
interval_sec=${INTERVAL:-$default_interval_sec}

slack_messages=$(
  TOKEN="$slack_token" \
  CHANNEL=CH80A4W3D \
  OLDEST="$interval_sec" \
  python "${basedir}"/../../lib/slack/channel-message.py
)

echo "$slack_messages" | jq '.["messages"][]["text"]'

