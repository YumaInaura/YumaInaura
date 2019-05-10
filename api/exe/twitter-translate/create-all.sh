#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

eval "$base_dir"/en-tweet.sh
#eval "$base_dir"/ja-en-tweet.sh
