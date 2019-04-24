#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"
source "${base_dir}/../twitter-setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

REPOSITORY=${REPOSITORY:-YumaInaura}

export OWNER=YumaInaura \
       REPOSITORY="$REPOSITORY" \
       API_KEY="$github_api_key" \
       TITLE="Yuma Inaura was Here ${jst_date} on Twitter" \
       FILE="${log_dir}/"$TWITTER_EN_USER_NAME".md" \
       LABELS=medium,english,twitter

"${api_dir}/github/create-or-edit-issue.py"
