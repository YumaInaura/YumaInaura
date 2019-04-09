#!/usr/bin/env bash

basedir=$(dirname "$0")

TOKEN=$("$basedir"/get-token.sh) \
  "$basedir"/translate-json.py

