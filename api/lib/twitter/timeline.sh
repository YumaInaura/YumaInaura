#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

logdir="$basedir"/log
mkdir -p "$logdir"

eval "$basedir"/timeline.py | tee "$logdir"/timeline.log

