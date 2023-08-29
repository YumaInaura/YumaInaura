---
title: "自分のQiitaの記事を全てzennにコピーする (Rubyスクリプト)"
emoji: "🖥"
type: "tech"
topics: ["ruby"]
published: true
---
# 概要

- QiitaAPIでQiitaの記事内容を取得する (APIの申請が必要)
- ZennとGithub連携しているレポジトリにlocalファイルを作成する
- git push してZennに記事を反映する

# 実行例

```
USER_ID=xxxx QIITA_TOKEN=********************** ruby qiita-to-zenn.rb
```

# コード例

```rb
require 'net/https'
require 'uri'
require 'json'

uri = URI.parse("https://qiita.com/")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request_header = {'Content-Type' =>'application/json', "Authorization" => "Bearer #{ENV['QIITA_TOKEN']}"}

round = 0

# ページングしながらQiitaの全記事を取得
(1..100).each do |i|
  get_url = "https://qiita.com/api/v2/users/#{ENV['USER_ID']}/items?page=#{i}&per_page=100"

  get_request = Net::HTTP::Get.new(get_url, request_header)

  get_response = http.request(get_request)

  items = JSON.parse(get_response.response.body)

  if items.empty?
    break
  end

  items.each do |item|
    round += 1

    puts "#{round} #{item['url']}"
    puts "#{item['title']} (#{item['body'].length}文字)"

    omitted_title = item['title'].slice(0..69)

    # 複数回実行しても記事が重複しないようにQiitaの記事作成日時をslugとして利用する
    slug = item['created_at'].gsub(':', '_').gsub('+', '-').gsub('T', 't')

    filepath = "../articles/qiita-#{slug}.md"

    puts filepath

    # Qiitaのタグをそのままzennで使う
    tag_names = item['tags'].map { |tag| tag['name'] }

    # Qiitaでポエムタグがついている記事はideaに、そうでない記事はtechに分類する
    type = if tag_names.include?('ポエム')
      'idea'
    else
      'tech'
    end

    filebody = <<~EOM
    ---
    title: #{omitted_title.to_json}
    emoji: "🖥"
    type: "#{type}"
    topics: #{tag_names}
    published: true
    ---

    #{item['body']}
    EOM

    # puts filebody

    file = File.open(filepath, "w")
    file.write(filebody)
    file.close
  end

  sleep 1
end

```

# 動作例

git push するとすごい勢いでzennに記事が作成されてゆく
(1秒に2-3記事ぐらい)

![image](https://github.com/YumaInaura/YumaInaura/assets/13635059/8a38a7b5-c10d-442a-9afb-01cd0d8053d7)


# 注意

Githubからzennの記事を削除することは出来ないので注意

# エラー

yamlでタイトルに構文エラーがあるとエラーが起こって途中で反映が止まる
上記スクリプトでは文字エスケープをして対策済み

例:

配列になってしまっている

```
title: [あいうえお]
```


![image](https://github.com/YumaInaura/YumaInaura/assets/13635059/e2284c85-8df8-4b30-8337-1cadec48fa1a)

本文の文字数エラー

![image](https://github.com/YumaInaura/YumaInaura/assets/13635059/46e5cb67-8638-454f-9e76-997f4c2ffa14)

# チャットメンバー募集


何か質問、悩み事、相談などあればLINEオープンチャットもご利用ください。

https://line.me/ti/g2/eEPltQ6Tzh3pYAZV8JXKZqc7PJ6L0rpm573dcQ


# Twitter

https://twitter.com/YumaInaura
