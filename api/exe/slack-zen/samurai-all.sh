#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

export SETTING_FILE=samurai-setting.sh

basedir=$(dirname "$0")
source "$basedir"/prepare.sh

eval "$basedir"/yesterday-slack-message.sh
cat "$slack_user_message_log_file" jq reverse | "$api_dir"/slack/markdown.py | tee "$markdown_text_log_file"

eval "$basedir"/github-issue-list.sh

cat "$markdown_text_log_file" | \
  TITLE="$ja_github_title" \
  LABELS=medium,hatena,japanese,twitter
  "${basedir}"/github-create-or-append-daily-issue.sh

