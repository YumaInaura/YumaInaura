#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"

"$base_dir"/twitter-fetch-timeline.sh
"$base_dir"/twitter-format.sh
"$base_dir"/twitter-markdown.sh
"$base_dir"/twitter-profiles.sh
