require_relative '../layabout/slack/user.rb'
require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class Users

    def list
      process 'members', SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/users.list')
    end

    def process(key, slack_response)
      data = slack_response.body.fetch(key)
      return data.map{|json| ::Layabout::Slack::User.new(json) }
    end
  end
end
