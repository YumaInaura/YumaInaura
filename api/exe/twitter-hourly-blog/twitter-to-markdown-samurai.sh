#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

mkdir -p "$log_dir"

cat "$log_dir"/timeline-jst-yesterday.json \
  | "$api_dir"/twitter/filter.py \
    --end-with=j \
    --match='エンジニ|プログラ|仕事|就職|Wanted|Qiita|python|ruby|vue|docker' \
  | "$api_dir"/twitter/markdown.py \
  | tee "$log_dir"/samurai.md

