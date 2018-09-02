#!/usr/bin/env bash -eu

readonly file_path=$(basename "$0")
readonly current_dir=$(echo "$0" | sed -e "s/\/${file_path}$//g")

readonly converted=$("${current_dir}/../bin/scfill" "${current_dir}/../fixtures/script.sh")

echo $converted

readonly expected=$(cat << EOM

EOM
)
