date=$(TZ=Asia/Tokyo date +'%Y-%m-%d')

api_dir="${basedir}/../../lib"
log_dir="${basedir}"/log

slack_channel_history_log_file="$log_dir"/slack-channel-history.json
slack_message_log_file="$log_dir"/slack-message.json
slack_user_message_log_file="$log_dir"/slack-user-message.json
slack_message_plain_log_file="$log_dir"/slack-message-plain.txt

github_title="いなうらゆうまはここにいた ${date}"
github_repository="playground"

github_issue_list_log_file="$log_dir"/github-issue.json
github_found_issue_log_file="$log_dir"/github-found-issue.json

