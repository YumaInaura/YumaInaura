for page in {1..100}; do
  curl -s "https://qiita.com/api/v2/tags?page=${page}&per_page=100&sort=count" | jq '.[].id';
  sleep 5
done | tee qiita-tag.txt
