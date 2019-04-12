#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

base_dir=$(dirname "$0")
source "${base_dir}/prepare.sh"

slack_message=$(cat "$markdown_text_log_file")

if [ -z "$slack_message" ]; then
  echo Slack message is empty Nothing to do
  exit
fi

"$base_dir"/github-issue-list.sh && \
"$base_dir"/github-create-or-append-daily-issue-multi-language.sh

