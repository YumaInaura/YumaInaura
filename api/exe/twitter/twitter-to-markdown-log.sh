#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

api_dir="${basedir}/../../lib"

pushd ${api_dir}/twitter
  mkdir -p log
  ALL=1 ./timeline.py > log/timeline.log
  cat log/timeline.log | OWN_USER_ID=473780756 ./filter-own.py > log/timeline-own-tweet.log
  cat log/timeline-own-tweet.log | ./jst-datetime-filter.py > log/timeline-jst-yesterday.log

  cat log/timeline-jst-yesterday.log | ./markdown.py > log/markdown.log

  cat log/markdown.log | "$api_dir"/google-translate/translate.sh  > log/en-translated.md
 
   cat log/timeline-jst-yesterday.log | ./filter.py \
     --end-with=j \
     --match='エンジニ|プログラ|仕事|就職|Wanted|Qiita|python|ruby|vue|docker' \
     | ./markdown.py \
       > log/samurai.md
popd

