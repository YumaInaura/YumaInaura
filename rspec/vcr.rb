# https://relishapp.com/vcr/vcr/v/5-1-0/docs/getting-started

# gem install vcr
# gem install webmock
# gem install faraday

require "vcr"
require "faraday"
require "pry" # for debug

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'cassettes'
  c.debug_logger = File.open("vcr.log", 'w')
end

describe do
  it do
    VCR.use_cassette('example') do
      response = Faraday.get("https://example.com")
      expect(response.success?).to be true
    end
  end
end
