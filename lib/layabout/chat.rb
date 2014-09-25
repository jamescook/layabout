require 'uri'
require 'httpi'
require 'forwardable'
require 'json'

module Layabout
  class Chat
    extend Forwardable

    def_delegators :@configuration, :domain, :team, :token

    attr_reader :text, :channel

    def initialize(options={})
      @text          = options.fetch(:text)
      @channel       = options.fetch(:channel)
      @username      = options[:username]
      @parse         = options[:parse]
      @link_names    = options[:link_names]
      @attachments   = options[:attachments]
      @unfurl_links  = options[:unfurl_links]
      @icon_url      = options[:icon_url]
      @icon_emoji    = options[:icon_emoji]
      @configuration = ::Layabout.configuration
    end

    def post_message
      http_request.query = build_query

      SlackResponse.new(HTTPI.get(http_request))
    end

    private

    def http_request
      @http_request ||= HTTPI::Request.new(endpoint.to_s).tap do |httpi|
        httpi.auth.ssl.verify_mode = :peer
      end
    end

    def build_query
      {
        'channel' => channel,
        'text'    => text,
        'token'   => token
      }.merge(optional_params)
    end

    def optional_params
      {}.tap do |hash|
        hash['username']     = @username     if @username
        hash['parse']        = @parse        if @parse
        hash['link_names']   = @link_names   if @link_names
        hash['attachments']  = @attachments  if @attachments
        hash['unfurl_links'] = @unfurl_links if @unfurl_links
        hash['icon_url']     = @icon_url     if @icon_url
        hash['icon_emoji']   = @icon_emoji   if @icon_emoji
      end
    end

    def endpoint
      domain.tap do |uri|
        uri.path = '/api/chat.postMessage'
      end
    end
  end
end
