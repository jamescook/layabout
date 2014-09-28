require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class DeleteChat

    attr_reader :timestamp, :channel

    def initialize(options={})
      @channel       = options.fetch(:channel)
      @timestamp     = options.fetch(:timestamp)
    end

    def delete
      SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/chat.delete', build_query)
    end

    private

    def build_query
      {
        'channel' => channel,
        'ts'      => timestamp
      }
    end
  end
end
