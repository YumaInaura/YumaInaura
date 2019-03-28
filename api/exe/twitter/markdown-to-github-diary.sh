#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

api_dir="${basedir}/../../lib"

export USERNAME=YumaInaura \
       REPOSITORY=YumaInaura \
       PASSWORD="$github_api_key" \
       TITLE="いなうらゆうま はここにいた ${jst_date} on Twitter" \
       FILE="${api_dir}/twitter/log/markdown.log" \
       LABELS=medium,hatena,japanese,twitter

python "${api_dir}/github/create-or-edit-issue.py"

