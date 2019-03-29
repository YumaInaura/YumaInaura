#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

cat "$github_issue_list_log_file" | \
  jq "map(select(.title == \"$github_title\"))" \
  | tee "$github_found_issue_log_file"

cat "$github_found_issue_log_file" | \
  jq '.[0]' | \
  tee "$github_found_top_issue_log_file"

