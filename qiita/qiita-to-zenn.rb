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

    #{item['body'].slice(0..79999)}
    EOM

    # puts filebody

    file = File.open(filepath, "w")
    file.write(filebody)
    file.close
  end

  sleep 1
end
