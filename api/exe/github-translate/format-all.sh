#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

eval "$base_dir"/en-need-translate-issue.sh
eval "$base_dir"/en-translate.sh
eval "$base_dir"/en-seed.sh

