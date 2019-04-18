#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

log_dir="$base_dir"/log

REPOSITORY=${REPOSITORY:-YumaInaura}

export OWNER=YumaInaura \
       REPOSITORY="$REPOSITORY" \
       API_KEY="$github_api_key" \
       TITLE=$(cat "$log_dir"/github-title.txt) \
       FILE="${log_dir}/github-body.md" \
       LABELS=medium,hatena,japanese,twitter

"${api_dir}/github/create-or-edit-issue.py"

