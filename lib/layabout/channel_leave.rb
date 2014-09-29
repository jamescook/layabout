require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class ChannelLeave

    attr_reader :channel_id

    def initialize(channel_id)
      @channel_id = channel_id
    end

    def leave
      SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/channels.leave', channel: channel_id)
    end
  end
end
