#!/usr/bin/env bash

basedir=$(dirname "$0")


if [ $(uname -s) = "Darwin" ]; then
  TOKEN=$("$basedir"/get-token.sh) \
    python "$basedir"/translate.py | \
    jq '.data.translations[].translatedText'
else
  "$basedir"/translate-docker.sh
fi

