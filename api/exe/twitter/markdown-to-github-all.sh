#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8
basedir=$(dirname "$0")

source "${basedir}/../../setting.sh"
jst_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%y-%m-%d')

eval "$basedir"/markdown-to-github-diary-en.sh
eval "$basedir"/markdown-to-github-diary-samurai.sh
eval "$basedir"/markdown-to-github-diary.sh

