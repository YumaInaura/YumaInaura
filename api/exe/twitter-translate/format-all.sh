#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

eval "$base_dir"/filter-api-resource.sh
eval "$base_dir"/filter-own.sh
eval "$base_dir"/filter-recent.sh


