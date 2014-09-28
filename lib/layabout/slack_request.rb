require 'httpi'

module Layabout
  class SlackRequest
    extend Forwardable

    def_delegators :@configuration, :domain, :team, :token

    attr_reader :params

    def initialize(path, params={})
      @path   = path
      @params = params.dup
      @configuration = ::Layabout.configuration
      @params[:token] = token unless params.key?(:token) 
    end

    def perform(verb)
      http_request.query = params if verb == :get
      http_request.body  = params if verb == :post
      HTTPI.request(verb, http_request)
    end

    # Webhooks are handled in a non-compatible way with the other APIs
    def perform_webhook
      http_request.body  = {'text'  => params[:text]}.to_json.to_s
      http_request.query = {'token' => params[:token]}
      HTTPI.post(http_request)
    end

    private 

    def endpoint
      domain.tap do |uri|
        uri.path = @path
      end
    end

    def http_request
      @http_request ||= HTTPI::Request.new(endpoint.to_s).tap do |httpi|
        httpi.auth.ssl.verify_mode = :peer
      end
    end
  end
end
