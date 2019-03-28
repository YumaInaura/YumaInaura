#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
api_dir="${basedir}/../../lib"
log_dir="${basedir}"/log

mkdir -p "$log_dir"
rm -rf "$log_dir"/*github*

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')
github_title="いなうらゆうまはここにいた ${date}"

github_repository="playground"

issue_list_log_file="$log_dir"/github-issue.json
found_issue_log_file="$log_dir"/github-found-issue.json

OWNER=YumaInaura \
REPOSITORY="$github_repository" \
  python "$api_dir"/github/issue.py \
    | tee "$issue_list_log_file"

cat "$issue_list_log_file" | \
  jq -c 'select(.["title"] | contains("'"$github_title"'"))' \
  | tee "$found_issue_log_file"

