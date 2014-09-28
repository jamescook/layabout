require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class Chat

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
    end

    def post_message
      SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/chat.postMessage', build_query)
    end

    def build_query
      {
        'channel' => channel,
        'text'    => text,
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
  end
end
