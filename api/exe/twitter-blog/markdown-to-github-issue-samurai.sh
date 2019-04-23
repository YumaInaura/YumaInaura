#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

REPOSITORY=${REPOSITORY:-YumaInaura}

export OWNER=YumaInaura \
       REPOSITORY="$REPOSITORY" \
       API_KEY="$github_api_key" \
       TITLE="とあるRailsエンジニアが再就職活動を共有したがっているようだ ${jst_date} on Twitter" \
       FILE="${log_dir}/samurai.md" \
       LABELS=medium,hatena,japanese,twitter,qiita

"${api_dir}/github/create-or-edit-issue.py"
