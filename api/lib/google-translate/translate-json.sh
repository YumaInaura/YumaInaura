#!/usr/bin/env bash

basedir=$(dirname "$0")

if [ $(uname -s) = "Darwin" ]; then
  TOKEN=$("$basedir"/get-token.sh) \
    python "$basedir"/translate-json.py
else
  "$basedir"/translate.sh
fi

