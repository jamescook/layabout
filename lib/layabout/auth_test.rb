require_relative '../layabout/slack_response.rb'
require_relative '../layabout/slack_request.rb'

module Layabout
  class AuthTest

    def get
      SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/auth.test')
    end
  end
end
