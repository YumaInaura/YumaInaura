#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
source "${basedir}/prepare.sh"

OWNER=YumaInaura \
REPOSITORY="$github_repository" \
  python "$api_dir"/github/issue.py \
    | tee "$github_issue_list_log_file"

