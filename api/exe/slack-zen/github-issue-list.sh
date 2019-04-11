#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
source "${base_dir}/prepare.sh"

OWNER="$github_owner" \
REPOSITORY="$github_repository" \
  python "$api_dir"/github/issue.py \
    | tee "$github_issue_list_log_file"

