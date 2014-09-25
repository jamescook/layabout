require 'uri'
require 'httpi'
require 'forwardable'
require_relative '../layabout/slack/channel.rb'

# TODO This code was originally using Net::HTTP instead of HTTPI
# Needs some refactoring
module Layabout

  class Channels
    extend Forwardable

    def_delegators :@configuration, :domain, :team, :token

    def initialize(options={})
      @configuration = ::Layabout.configuration
    end

    def list
      process 'channels', SlackResponse.new(HTTPI.get(http_request(list_endpoint)))
    end

    def info(channel_id)
      process('channel', SlackResponse.new(HTTPI.get(http_request(info_endpoint(channel_id)))))
    end

    def leave(channel_id)
      SlackResponse.new(HTTPI.get(http_request(leave_endpoint(channel_id))))
    end

    def join(channel_name)
      SlackResponse.new(HTTPI.get(http_request(join_endpoint(channel_name))))
    end

    private

    def process(key, slack_response)
      data = slack_response.body.fetch(key)
      if data.kind_of?(Array)
        return data.map{|json| ::Layabout::Slack::Channel.new(json) }
      else
        return ::Layabout::Slack::Channel.new(data)
      end
    end

    def http_request(endpoint)
      @http_request ||= HTTPI::Request.new(endpoint.to_s).tap do |httpi|
        httpi.auth.ssl.verify_mode = :peer
      end
    end

    def join_endpoint(channel_name)
      build_channel_endpoint('join').tap do |uri|
        channel_name.sub!('#', '%23')
        uri.query = uri.query + "&name=#{channel_name}"
      end
    end

    def leave_endpoint(channel_id)
      build_channel_endpoint('leave').tap do |uri|
        uri.query = uri.query + "&channel=#{channel_id}"
      end
    end

    def list_endpoint
      build_channel_endpoint 'list'
    end

    def info_endpoint(channel_id)
      build_channel_endpoint('info').tap do |uri|
        uri.query = uri.query + "&channel=#{channel_id}"
      end
    end

    def build_channel_endpoint(action)
      domain.tap do |uri|
        uri.path = "/api/channels.#{action}"
        uri.query = "token=#{token}"
      end
    end
  end
end
