#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"

jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

api_dir="${basedir}/../../lib"

log_dir="$basedir"/log
mkdir -p "$log_dir"

ALL=1 "$api_dir"/twitter/timeline.py > "$log_dir"/timeline.log
cat "$log_dir"/timeline.log | OWN_USER_ID=473780756 "$api_dir"/twitter/filter-own.py > "$log_dir"/timeline-own-tweet.log
cat "$log_dir"/timeline-own-tweet.log | "$api_dir"/twitter/jst-datetime-filter.py > "$log_dir"/timeline-jst-yesterday.log

cat "$log_dir"/timeline-jst-yesterday.log | "$api_dir"/twitter/markdown.py > "$log_dir"/markdown.log

cat "$log_dir"/markdown.log | "$api_dir"/google-translate/translate.sh  > "$log_dir"/en-translated.md

 cat "$log_dir"/timeline-jst-yesterday.log | "$api_dir"/twitter/filter.py \
   --end-with=j \
   --match='エンジニ|プログラ|仕事|就職|Wanted|Qiita|python|ruby|vue|docker' \
   | "$api_dir"/twitter/markdown.py \
     > "$log_dir"/samurai.md
