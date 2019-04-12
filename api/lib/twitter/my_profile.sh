#!/usr/bin/env bash

base_dir=$(dirname "$0")

"$base_dir"/common.py  https://api.twitter.com/1.1/users/show.json '{"screen_name": "YumaInaura"}'

