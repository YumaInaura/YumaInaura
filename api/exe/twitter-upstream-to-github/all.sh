#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

"$base_dir"/twitter-own-fav.sh
"$base_dir"/upstream-timeline.sh
"$base_dir"/markdown.sh
"$base_dir"/github-create-issue.sh

