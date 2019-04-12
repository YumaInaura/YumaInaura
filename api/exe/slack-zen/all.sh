#!/usr/bin/env bash

set -eu

export LC_CTYPE=en_US.UTF-8

base_dir=$(dirname "$0")

"$base_dir"/slack-all.sh && \
"$base_dir"/format-all.sh && \
"$base_dir"/github-all.sh

