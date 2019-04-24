#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"

"$base_dir"/twitter-to-markdown-ja.sh
"$base_dir"/markdown-to-github-issue-ja.sh

