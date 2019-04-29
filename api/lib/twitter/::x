#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

logdir="$base_dir"/log
mkdir -p "$logdir"

ALL=1 \
  "$base_dir"/timeline.sh \
  > "$logdir"/timeline.json

echo "$logdir"/timeline.json

