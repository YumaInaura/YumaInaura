#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

export SETTING_FILE=samurai-setting.sh

base_dir=$(dirname "$0")
source "$base_dir"/prepare.sh

eval "$base_dir"/yesterday-slack-message.sh
cat "$slack_user_message_log_file" jq reverse | "$api_dir"/slack/markdown.py | tee "$markdown_text_log_file"

eval "$base_dir"/github-issue-list.sh

cat "$markdown_text_log_file" | \
  TITLE="$ja_github_title" \
  LABELS=medium,hatena,japanese,twitter
  "${base_dir}"/github-create-or-append-daily-issue.sh

