# https://relishapp.com/vcr/vcr/v/5-1-0/docs/getting-started

# gem install vcr
# gem install webmock
# gem install faraday

require "vcr"
require "faraday"
require "pry" # for debug

VCR.configure do |c|
  c.hook_into :webmock
  # need `mkdir ./casettes`
  c.cassette_library_dir = 'cassettes'
  c.debug_logger = File.open("vcr.log", 'w')
  c.filter_sensitive_data("<SECRET_KEY>") { ENV["SECRET_KEY"] }
end

describe do
  # OK
  it do
    VCR.use_cassette('example1') do
      response = Faraday.get("https://example.com")
      expect(response.success?).to be true
    end
  end

  # NG
  # VCR.use_cassette must be in "it"
  #      VCR::Errors::UnhandledHTTPRequestError:
  #
  #
  #        ================================================================================
  #        An HTTP request has been made that VCR does not know how to handle:
  #          GET https://example.com/
  #
  #        There is currently no cassette in use. There are a few ways
  #        you can configure VCR to handle this request:

  VCR.use_cassette('example2') do
    it do
      response = Faraday.get("https://example.com")
      expect(response.success?).to be true
    end
  end

  # Once OK but Twice NG
  # Because request URL different everytime
  #
  #   VCR::Errors::UnhandledHTTPRequestError:
  #
  #
  #   ================================================================================
  #   An HTTP request has been made that VCR does not know how to handle:
  #     GET https://example.com/?param=0.20117927761663523

  #   VCR is currently using the following cassette:
  #     - /Users/yumainaura/example3.yml
  #       - :record => :once
  #       - :match_requests_on => [:method, :uri]

  it do
    VCR.use_cassette('example3') do
      response = Faraday.get("https://example.com?param=#{Random.rand}")
      expect(response.success?).to be true
    end
  end

  # OK even if ENV SECRET_KEY different between every run
  #
  # e.g
  #   SECRET_KEY=xxx rspec vcr_unhandled_failure.rb
  #   SECRET_KEY=yyy rspec vcr_unhandled_failure.rb
  #   SECRET_KEY=zzz rspec vcr_unhandled_failure.rb
  #
  #
  # VCR cassettes:
  #
  # ---
  # http_interactions:
  # - request:
  #     method: get
  #     uri: https://example.com/?param=<SECRET_KEY>
  #     body:
  #       encoding: US-ASCII
  #       string: ''
  it do
    VCR.use_cassette('example4') do
      response = Faraday.get("https://example.com?param=#{ENV.fetch("SECRET_KEY")}")
      expect(response.success?).to be true
    end
  end
end

# guid in error message
#        ================================================================================
#        An HTTP request has been made that VCR does not know how to handle:
#          GET https://example.com/

#        There is currently no cassette in use. There are a few ways
#        you can configure VCR to handle this request:

#          * If you're surprised VCR is raising this error
#            and want insight about how VCR attempted to handle the request,
#            you can use the debug_logger configuration option to log more details [1].
#          * If you want VCR to record this request and play it back during future test
#            runs, you should wrap your test (or this portion of your test) in a
#            `VCR.use_cassette` block [2].
#          * If you only want VCR to handle requests made while a cassette is in use,
#            configure `allow_http_connections_when_no_cassette = true`. VCR will
#            ignore this request since it is made when there is no cassette [3].
#          * If you want VCR to ignore this request (and others like it), you can
#            set an `ignore_request` callback [4].

#        [1] https://www.relishapp.com/vcr/vcr/v/5-1-0/docs/configuration/debug-logging
#        [2] https://www.relishapp.com/vcr/vcr/v/5-1-0/docs/getting-started
#        [3] https://www.relishapp.com/vcr/vcr/v/5-1-0/docs/configuration/allow-http-connections-when-no-cassette
#        [4] https://www.relishapp.com/vcr/vcr/v/5-1-0/docs/configuration/ignore-request
#        ================================================================================
#      # /Users/yumainaura/ghq/github.com/YumaInaura/YumaInaura/rspec/vcr.rb:27:in `block (3 levels) in <top (required)>'

# Finished in 0.0327 seconds (files took 0.72476 seconds to load)
# 1 example, 1 failure
