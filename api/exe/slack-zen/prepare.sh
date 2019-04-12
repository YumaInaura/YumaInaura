shopt -s expand_aliases

if [ $(uname -s) = "Darwin" ]; then
  alias date=gdate
  alias sed=gsed
fi

alias python=python3

base_dir=$(dirname "$0")

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')
yesterday_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

api_dir="$base_dir"/../../lib
log_dir="$base_dir"/log
mkdir -p "$log_dir"

default_setting_file=zen-setting.sh
setting_file=${SETTING_FILE:-$default_setting_file}

source "$base_dir/$setting_file"
