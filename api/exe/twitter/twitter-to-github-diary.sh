#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")

source ~/.secret/setting.sh
source "${basedir}/../../setting.sh"
api_dir="${basedir}/../../lib"

cd "$api_dir"

pushd ${api_dir}/twitter
  mkdir -p log
  INCLUDE_RTS=1 INCLUDE_REPLIES=1 python timeline.py > log/timeline.log
  cat log/timeline.log | python jst-datetime-filter.py > log/timeline-jst-yesterday.log
  cat log/timeline-jst-yesterday.log | python markdown.py > log/markdown.log
popd

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

#export USERNAME=YumaInaura \
#  REPOSITORY=YumaInaura \
#  PASSWORD="$github_api_key" \
#  TITLE="いなうらゆうま はここにいた ${jst_date} on Twitter" \
#  FILE=./twitter/log/markdown.log \
#  LABELS=medium,hatena,japanese,twitter
