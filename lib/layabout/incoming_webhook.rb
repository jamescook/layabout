require 'uri'
require 'httpi'
require 'forwardable'
require 'json'

module Layabout
  class IncomingWebhook
    extend Forwardable

    def_delegators :@configuration, :domain, :team

    attr_reader :token, :message

    def initialize(options={})
      @token   = options.fetch(:token) # The token for Webhooks is not the same as your API token
      @message = options.fetch(:message)
      @configuration = ::Layabout.configuration
    end

    def post
      http_request.body = {'text' => message}.to_json.to_s

      SlackResponse.new(HTTPI.post(http_request))
    end

    private

    def http_request
      @http_request ||= HTTPI::Request.new(endpoint.to_s).tap do |httpi|
        httpi.auth.ssl.verify_mode = :peer
      end
    end

    def endpoint
      domain.tap do |uri|
        uri.path = '/services/hooks/incoming-webhook'
        uri.query = "token=#{token}"
      end
    end
  end
end
