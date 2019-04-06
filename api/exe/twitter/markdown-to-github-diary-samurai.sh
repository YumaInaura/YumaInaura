#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

export OWNER=YumaInaura \
       REPOSITORY=YumaInaura \
       API_KEY="$github_api_key" \
       TITLE="とあるRailsエンジニアをお求めの方はこちらまで ${jst_date} on Twitter" \
       FILE="${log_dir}samurai.md" \
       LABELS=medium,hatena,japanese,twitter,qiita

python "${api_dir}/github/create-or-edit-issue.py"
