#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

mkdir -p "$log_dir"
rm -rf "$log_dir"/*github*

OWNER=YumaInaura \
REPOSITORY="$github_repository" \
  python "$api_dir"/github/issue.py \
    | tee "$github_issue_list_log_file"

cat "$github_issue_list_log_file" | \
  jq '.[]' | \
  jq -c 'select(.["title"] | contains("'"$github_title"'"))' \
  | tee "$github_found_issue_log_file"

