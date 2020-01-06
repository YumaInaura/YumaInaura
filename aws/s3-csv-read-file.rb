
# https://www.rubydoc.info/github/aws/aws-sdk-ruby/Aws%2FS3%2FObject:presigned_url

require 'aws-sdk-s3'
require 'csv'
require 'open-uri'

credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
s3_resource = Aws::S3::Resource::new(region: ENV['AWS_REGION'], credentials: credentials) # e.g ap-northeast-1

# If no bucket then create
# s3_bucket.create

s3_bucket = s3_resource.bucket(ENV['AWS_BUCKET'])

object = s3_bucket.object('sjis.csv')
object.upload_file('./tmp/sjis.csv')

presigned_url = object.presigned_url(:get, expires_in: 7*24*60*60)

require 'open-uri'

presigned_url = 'https://yumainaura.s3.ap-northeast-1.amazonaws.com/sjis.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4INFFTNLCQ6PIZOP%2F20200106%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Date=20200106T093641Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=cf53e945cb2ab790c99cb25e2dee503ac0844ac53aa632186fc89e3a892b3ce1'

csv_utf8_strings = open(URI.parse(presigned_url)).read.encode('UTF-8', 'Shift_JIS')

CSV.new(csv_utf8_strings, headers: true).each do |line|
  puts "#{line[0]} / #{line[1]}"
end

# 1234 / わー
# 5678 / わー

p presigned_url
