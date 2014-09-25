require 'uri'
require 'net/http'
require 'openssl'
require 'forwardable'

module Layabout
  class AuthTest
    extend Forwardable

    def_delegators :@configuration, :domain, :team, :token

    def initialize(options={})
      @configuration = ::Layabout.configuration
    end

    def get
      SlackResponse.new(HTTPI.get(http_request))
    end

    private

    def http_request
      HTTPI::Request.new(endpoint.to_s).tap do |httpi|
        httpi.auth.ssl.verify_mode = :peer
      end
    end

    def endpoint
      domain.tap do |uri|
        uri.path = '/api/auth.test'
        uri.query = "token=#{token}"
      end
    end
  end
end
