#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

echo "" > "$formatted_message_log_file"

for text in $(cat "$slack_message_plain_log_file"); do
  echo "$text" | \
  "$api_dir"/slack/format-text.py \
  >> "$formatted_message_log_file"
done

cat "$formatted_message_log_file" | \
  jq -r '.atomic_text_markdown' | \
  tee "$markdown_text_log_file"

