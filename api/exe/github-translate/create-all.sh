#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

eval "$base_dir"/en-create-issue.sh
eval "$base_dir"/remove-label-from-issue-seed.sh
eval "$base_dir"/remove-label-from-issue.sh

