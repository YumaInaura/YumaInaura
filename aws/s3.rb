# https://www.rubydoc.info/github/aws/aws-sdk-ruby/Aws%2FS3%2FObject:presigned_url

require 'aws-sdk-s3'
require 'csv'

credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
s3_resource = Aws::S3::Resource::new(region: ENV['AWS_REGION'], credentials: credentials) # e.g ap-northeast-1

# If no bucket then create
# s3_bucket.create

s3_bucket = s3_resource.bucket(ENV['AWS_BUCKET'])
# <Aws::S3::Bucket:0x00007fd7145b34f0 @arn=nil, @client=#<Aws::S3::Client>, @data=nil, @name="yumainaura", @waiter_block_warned=false>

object = s3_bucket.object("path/to/file_#{Time.now.to_i}.txt")
# #<Aws::S3::Object:0x00007fd7139fb8b0
#  @bucket_name="yumainaura",
#  @client=#<Aws::S3::Client>,
#  @data=nil,
#  @key="path/to/file_1578302095.txt",
#  @waiter_block_warned=false>

object.put(body: 'ABC')

presigned_url = object.presigned_url(:get, expires_in: 10)
# => "https://yumainaura.s3.ap-northeast-1.amazonaws.com/path/to/file_1578302095.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4INFFTNLCQ6PIZOP%2F20200106%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Date=20200106T091516Z&X-Amz-Expires=10&X-Amz-SignedHeaders=host&X-Amz-Signature=f413cb0d564b69422f58b988cd2cbe39f4ca6b52e7a5e2975d1e22094706d3a0"

p presigned_url
