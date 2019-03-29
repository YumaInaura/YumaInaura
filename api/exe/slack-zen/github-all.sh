#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/prepare.sh"

slack_message=$(cat "$markdown_text_log_file")

if [ -z "$slack_message" ]; then
  echo Slack message is empty Nothing to do
  exit
fi

"$basedir"/github-issue-list.sh && \
"$basedir"/github-filter-issue.sh && \
"$basedir"/github-create-or-append-daily-issue.sh

