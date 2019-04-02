basedir=$(dirname "$0")

date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')
yesterday_date=$(TZ=Asia/Tokyo date --date='1 days ago' +'%Y-%m-%d')

api_dir="$basedir"/../../lib
log_dir="$basedir"/log
mkdir -p "$log_dir"

default_setting_file=zen-setting.sh
setting_file=${SETTING_FILE:-$default_setting_file}

source "$basedir/$setting_file"
