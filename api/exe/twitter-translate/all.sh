#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

mkdir -p "$log_dir"
rm -rf "$log_dir"/*

eval "$base_dir"/ja-timeline.sh

eval "$base_dir"/filter-api-resource.sh
eval "$base_dir"/filter-own.sh

eval "$base_dir"/filter-recent.sh

eval "$base_dir"/en-translate.sh
eval "$base_dir"/en-seed.sh
eval "$base_dir"/en-tweet.sh

eval "$base_dir"/ja-en-seed.sh
eval "$base_dir"/ja-en-tweet.sh
