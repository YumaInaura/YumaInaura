require 'securerandom'
require 'net/https'
require 'uri'
require 'json'
require 'pry'

uri = URI.parse("https://qiita.com/")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request_header = {'Content-Type' =>'application/json', "Authorization" => "Bearer #{ENV['QIITA_TOKEN']}"}

round = 0

(1..100).each do |i|
  get_url = "https://qiita.com/api/v2/users/#{ENV['USER_ID']}/items?page=#{i}&per_page=100"

  get_request = Net::HTTP::Get.new(get_url, request_header)

  get_response = http.request(get_request)

  items = JSON.parse(get_response.response.body)

  items.each do |item|
    round += 1

    puts "#{round} #{item['url']}"
    puts "#{item['title']}"

    omitted_title = item['title'].slice(1..70)

    slug = item['created_at'].gsub(':', '_').gsub('+', '-').gsub('T', 't')
    puts slug

    filepath = "../articles/qiita-#{slug}.md"
    puts filepath

    tag_names = item['tags'].map { |tag| tag['name'] }

    type = if tag_names.include?('ポエム')
      'tech'
    else
      'idea'
    end

    filebody = <<~EOM
    ---
    title: #{omitted_title}
    emoji: "🖥"
    type: "tech"
    topics: #{tag_names}
    published: true
    ---

    #{item['body']}
    EOM

    puts filebody

    file = File.open(filepath, "w")
    file.write(filebody)
    file.close

    sleep 1

    exit
  end
end
