#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

REPOSITORY=${REPOSITORY:-YumaInaura}


export OWNER=YumaInaura \
       REPOSITORY="$REPOSITORY" \
       API_KEY="$github_api_key" \
       TITLE=$(cat "$logi_dir"/github-title.txt) \
       FILE="${log_dir}/github-body.md" \
       LABELS=medium,hatena,japanese,twitter

"${api_dir}/github/create-or-edit-issue.py"

