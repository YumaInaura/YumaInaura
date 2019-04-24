#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"

"$base_dir"/twitter-to-markdown-yumainaura.sh
"$base_dir"/twitter-to-markdown-samurai.sh
"$base_dir"/twitter-to-markdown-yumainaura2nd.sh

