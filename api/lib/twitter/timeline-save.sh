#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

logdir="$base_dir"/log
mkdir -p "$logdir"

ALL=1 eval "$base_dir"/timeline.py | tee "$logdir"/timeline.json

