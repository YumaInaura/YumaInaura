source ~/.secret/setting.sh

shopt -s expand_aliases

if [ $(uname -s) = "Darwin" ]; then
  alias date=gdate
  alias sed=gsed
  alias echo=gecho
fi

alias python=python3

basedir=$(dirname "$0")
log_dir="$basedir"/log
api_dir="$basedir"/../../lib

