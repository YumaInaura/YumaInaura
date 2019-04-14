#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")

"$base_dir"/../..//lib/twitter/update-profile.py $(ls -1 "$base_dir"/../../lib/twitter/image/*.jpg | shuf -n 1)

