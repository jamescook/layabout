require 'uri'
require 'httpi'
require_relative 'layabout/slack_request.rb'
require_relative 'layabout/slack_response.rb'
require_relative 'layabout/helpers'

module Layabout
  extend self
  extend ::Layabout::Helpers

  def self.configure &block
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :token, :team

    def valid?
      !!team
    end

    def domain
      URI.parse("https://#{team}.slack.com/")
    end

    def merge(options={})
      @token = options[:token] if options.key?(:token)
      @team  = options[:team]  if options.key?(:team)
    end
  end
end
