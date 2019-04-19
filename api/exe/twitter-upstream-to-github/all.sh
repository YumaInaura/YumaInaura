#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

"$base_dir"/twitter-own-fav.sh
"$base_dir"/upstream-tweet-chain.sh
"$base_dir"/markdown.sh
"$base_dir"/github-create-issue.sh
"$base_dir"/destroy-fav.sh

