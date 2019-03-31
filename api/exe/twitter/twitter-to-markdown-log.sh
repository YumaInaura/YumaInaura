#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

api_dir="${basedir}/../../lib"

pushd ${api_dir}/twitter
  mkdir -p log
  ALL=1 python timeline.py > log/timeline.log
  cat log/timeline.log | python jst-datetime-filter.py > log/timeline-jst-yesterday.log
  cat log/timeline-jst-yesterday.log | python markdown.py > log/markdown.log
popd

