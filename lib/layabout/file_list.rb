require 'uri'
require 'httpi'
require 'forwardable'
require_relative '../layabout/slack/file.rb'

module Layabout
  class FileList
    extend Forwardable

    def_delegators :@configuration, :domain, :team, :token

    def initialize(options={})
      @configuration = ::Layabout.configuration
      @user          = options[:user]
      @ts_from       = options[:ts_from]
      @ts_to         = options[:ts_to]
      @types         = options[:types]
      @count         = options[:count]
      @page          = options[:page]
    end

    def list
      process 'files', SlackResponse.new(HTTPI.get(http_request(endpoint)))
    end

    private

    def process(key, slack_response)
      data = slack_response.body.fetch(key)
      # TODO Wrap this in an object that can be paginated
      return data.map{|json| ::Layabout::Slack::File.new(json) }
    end

    def http_request(endpoint)
      @http_request ||= HTTPI::Request.new(endpoint.to_s).tap do |httpi|
        httpi.auth.ssl.verify_mode = :peer
        httpi.query = build_query.merge('token' => token)
      end
    end

    def build_query
      {}.tap do |hash|
        hash['user']    = @user     if @user
        hash['ts_from'] = @ts_from  if @ts_from
        hash['ts_to']   = @ts_to    if @ts_to
        hash['types']   = @types    if @types
        hash['count']   = @count    if @count
        hash['page']    = @page     if @page
      end
    end

    def endpoint
      domain.tap do |uri|
        uri.path = "/api/files.list"
      end
    end
  end
end
