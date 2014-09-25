require 'uri'
require 'httpi'
require 'forwardable'
require 'json'

module Layabout
  class DeleteChat
    extend Forwardable

    def_delegators :@configuration, :domain, :team, :token

    attr_reader :timestamp, :channel

    def initialize(options={})
      @channel       = options.fetch(:channel)
      @timestamp     = options.fetch(:timestamp)
      @configuration = ::Layabout.configuration
    end

    def delete
      http_request.query = build_query

      SlackResponse.new(HTTPI.get(http_request))
    end

    private

    def http_request
      @http_request ||= HTTPI::Request.new(endpoint.to_s).tap do |httpi|
        httpi.auth.ssl.verify_mode = :peer
      end
    end

    def build_query
      {
        'channel' => channel,
        'ts'      => timestamp,
        'token'   => token
      }
    end

    def endpoint
      domain.tap do |uri|
        uri.path = '/api/chat.delete'
      end
    end
  end
end
