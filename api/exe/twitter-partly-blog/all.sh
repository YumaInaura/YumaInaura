#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

source "${base_dir}/../../setting.sh"

"$base_dir"/twitter-all.sh

"$base_dir"/github-issue-create.sh


