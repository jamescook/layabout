require 'uri'
require 'httpi'
require 'forwardable'
require_relative '../layabout/slack/user.rb'

module Layabout
  class Users
    extend Forwardable

    def_delegators :@configuration, :domain, :team, :token

    def initialize(options={})
      @configuration = ::Layabout.configuration
    end

    def list
      process 'members', SlackResponse.new(HTTPI.get(http_request(endpoint)))
    end

    private

    def process(key, slack_response)
      data = slack_response.body.fetch(key)
      return data.map{|json| ::Layabout::Slack::User.new(json) }
    end

    def http_request(endpoint)
      @http_request ||= HTTPI::Request.new(endpoint.to_s).tap do |httpi|
        httpi.auth.ssl.verify_mode = :peer
        httpi.query = {'token' => token}
      end
    end


    def endpoint
      domain.tap do |uri|
        uri.path = "/api/users.list"
      end
    end
  end
end
