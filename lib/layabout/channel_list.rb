require_relative '../layabout/slack/channel.rb'
require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class ChannelList

    def list
      process 'channels', SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/channels.list')
    end

    def process(key, slack_response)
      data = slack_response.body.fetch(key)
      return data.map{|json| ::Layabout::Slack::Channel.new(json) }
    end
  end
end
