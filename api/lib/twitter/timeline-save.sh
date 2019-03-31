#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")

logdir="$basedir"/log
mkdir -p "$logdir"

INCLUDE_RTS=1 INCLUDE_REPLIES=1 ALL=1 eval "$basedir"/timeline.py | tee "$logdir"/timeline.log

