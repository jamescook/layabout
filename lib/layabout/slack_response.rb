require 'json'

module Layabout
  class SlackResponse
    attr_reader :http_response

    def initialize(http_response)
      @http_response = http_response
    end

    def success?
      http_response.code == 200 && is_ok?
    end

    def error?
      !success?
    end

    def body
      json_returned? ? JSON.parse(http_response.body) : http_response.body
    end

    def [](key)
      body.fetch(key)
    end

    private

    def is_ok?
      json_returned? ? body['ok'] == true : body == 'ok'
    end

    def json_returned?
      http_response.headers['content-type'] == "application/json; charset=utf-8"
    end
  end
end
