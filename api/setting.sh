source ~/.secret/setting.sh

shopt -s expand_aliases

if [ $(uname -s) = "Darwin" ]; then
  alias date=gdate
  alias sed=gsed
  alias echo=gecho
fi

#alias python=python3
alias python3='docker run -it python-modules'

base_dir=$(dirname "$0")
log_dir="$base_dir"/log
api_dir="$base_dir"/../../lib

