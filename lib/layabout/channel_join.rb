require_relative '../layabout/slack/channel.rb'
require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class ChannelJoin

    attr_reader :channel_name

    def initialize(channel_name)
      @channel_name = channel_name
    end

    def join
      process 'channel', SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/channels.join', name: channel_name)
    end

    def process(key, slack_response)
      ::Layabout::Slack::Channel.new(slack_response.body)
    end
  end
end
