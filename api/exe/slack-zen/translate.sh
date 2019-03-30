#!/usr/bin/env bash

set -eu

basedir=$(dirname "$0")
source "${basedir}/prepare.sh"

eval "$api_dir"/google-translate/get-token.sh

