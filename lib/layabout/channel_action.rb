require_relative '../layabout/slack/channel.rb'
require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class ChannelAction

    attr_reader :channel_identifier, :process_result, :key

    def initialize(channel_identifier, options={})
      @channel_identifier = channel_identifier
      @key = options[:key] || 'channel'
    end

    def info
      process SlackResponse.new(request('info').perform(:get))
    end

    def join
      process SlackResponse.new(request('join').perform(:get))
    end

    def leave
      SlackResponse.new(request('leave').perform(:get))
    end

    private

    def request(action)
      ::Layabout::SlackRequest.new("/api/channels.#{action}", "#{key}" => channel_identifier)
    end

    def process(slack_response)
      ::Layabout::Slack::Channel.new(slack_response.body)
    end
  end
end
