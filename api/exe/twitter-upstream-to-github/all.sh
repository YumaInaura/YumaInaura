#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

eval "$base_dir"/upstream-timeline.sh "$1"
eval "$base_dir"/markdown.sh
eval "$base_dir"/github-create-issue.sh

