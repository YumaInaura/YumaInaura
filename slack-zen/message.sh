#!/usr/bin/env bash

set -eu

default_interval_sec=$(($(date +%s) - 60))
interval_sec=${INTERVAL:-$default_interval_sec}

source ./setting.sh

slack_messages=$(
  TOKEN="$slack_token" \
  CHANNEL=CH80A4W3D \
  OLDEST="$interval_sec" \
  python "$api_dir"/slack/channel-message.py
)

echo "$slack_messages" | jq '.["messages"][]["text"]'

