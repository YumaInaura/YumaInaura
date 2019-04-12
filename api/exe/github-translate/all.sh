#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

mkdir -p "$log_dir"
rm -rf "$log_dir"/*

eval "$base_dir"/issue.sh
eval "$base_dir"/en-need-translate-issue.sh
eval "$base_dir"/en-translate.sh
eval "$base_dir"/en-create-issu.sh
