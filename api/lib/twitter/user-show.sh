#!/usr/bin/env bash

base_dir=$(dirname "$0")

display_name=${1:-YumaInaura}

"$base_dir"/common.py  https://api.twitter.com/1.1/users/show.json '{"screen_name": "'"$display_name"'"}'

