require 'uri'
require 'httpi'
require_relative 'layabout/slack_response.rb'

module Layabout
  extend self

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
  end
end
