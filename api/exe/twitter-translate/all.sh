#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/../../setting.sh"

mkdir -p "$log_dir"
rm -rf "$log_dir"/*

eval "$basedir"/ja-timeline.sh
eval "$basedir"/filter-recent.sh
eval "$basedir"/en-translate.sh
eval "$basedir"/en-seed.sh
eval "$basedir"/en-tweet.sh
eval "$basedir"/ja-en-seed.sh
eval "$basedir"/ja-en-tweet.sh
