#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

eval "$base_dir"/markdown-to-github-diary-en.sh
eval "$base_dir"/markdown-to-github-diary-samurai.sh
eval "$base_dir"/markdown-to-github-diary.sh

