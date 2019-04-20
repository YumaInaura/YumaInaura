#!/usr/bin/env bash

set -eu

base_dir=$(dirname "$0")
source "${base_dir}/../../setting.sh"

mkdir -p "$log_dir"
rm -rf "$log_dir"/*


"${base_dir}"/fetch.sh
"${base_dir}"/english-tags.sh

