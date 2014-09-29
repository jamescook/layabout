require_relative '../layabout/slack/channel.rb'
require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class ChannelInfo

    attr_reader :channel_id

    def initialize(channel_id)
      @channel_id = channel_id
    end

    def info
      process 'channel', SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/channels.info', channel: channel_id)
    end

    def process(key, slack_response)
      ::Layabout::Slack::Channel.new(slack_response.body)
    end
  end
end
