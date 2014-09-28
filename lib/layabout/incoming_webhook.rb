require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class IncomingWebhook
    extend Forwardable

    attr_reader :token, :message

    def initialize(options={})
      @token   = options.fetch(:token) # The token for Webhooks is not the same as your API token
      @message = options.fetch(:message)
    end

    def post
      SlackResponse.new(request.perform_webhook)
    end

    private

    def request
      ::Layabout::SlackRequest.new("/services/hooks/incoming-webhook", params)
    end

    def params
      {:text => message, :token => token}
    end
  end
end
