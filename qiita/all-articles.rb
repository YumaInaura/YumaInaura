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
    patch_url = "https://qiita.com/api/v2/items/#{item['id']}"
    patch_request = Net::HTTP::Patch.new(patch_url, request_header)

    round += 1
    puts "#{round} #{item['url']}"
    puts "#{item['title']}"
  end

  sleep 1
end

# PATCH /api/v2/items/:item_id

# https://qiita.com/api/v2/docs#patch-apiv2itemsitem_id
