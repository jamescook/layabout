require_relative '../layabout/slack/file.rb'
require_relative '../layabout/slack_request.rb'
require_relative '../layabout/slack_response.rb'

module Layabout
  class FileList

    def initialize(options={})
      @user          = options[:user]
      @ts_from       = options[:ts_from]
      @ts_to         = options[:ts_to]
      @types         = options[:types]
      @count         = options[:count]
      @page          = options[:page]
    end

    def list
      process 'files', SlackResponse.new(request.perform(:get))
    end

    private

    def request
      ::Layabout::SlackRequest.new('/api/files.list', build_query)
    end

    private

    def process(key, slack_response)
      data = slack_response.body.fetch(key)
      # TODO Wrap this in an object that can be paginated
      return data.map{|json| ::Layabout::Slack::File.new(json) }
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
  end
end
