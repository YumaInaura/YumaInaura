#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

ALL=1 \
  | "$base_dir"/ext-tweets.py


