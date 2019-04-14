#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

"$base_dir"/markdown-to-github-issue-en.sh
"$base_dir"/markdown-to-github-issue-samurai.sh
"$base_dir"/markdown-to-github-issue-ja.sh

