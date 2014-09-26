require 'net/http/post/multipart'
require 'ostruct'

module Layabout
  class FileUpload
    extend Forwardable

    def_delegators :@configuration, :domain, :token

    attr_reader :filepath, :channels

    def initialize(options={})
      @configuration   = ::Layabout.configuration
      @filepath        = options.fetch(:filepath)
      @channels        = options.fetch(:channels)
      @filetype        = options[:filetype]
      @filename        = options[:filename]
      @title           = options[:title]
      @initial_comment = options[:initial_comment]
    end

    def upload
      SlackResponse.new(wrap(http_response))
    end

    private

    # HTTPI doesn't support multipart posts. We can work around it by using another gem
    # and handing off something that looks like a HTTPI response
    def wrap(http_response)
      OpenStruct.new.tap do |obj|
        obj.code    = http_response.code.to_i
        obj.body    = http_response.body
        obj.headers = {}
        http_response.each_header{|k,v| obj.headers[k] = v }
      end
    end

    def http_response
      req = Net::HTTP::Post::Multipart.new(endpoint.path, params)
      res = Net::HTTP.new(endpoint.host, endpoint.port)
      res.use_ssl = true
      res.request(req)
    end

    def required_params
      {
        "file"     => UploadIO.new(File.new(filepath), "text/plain", "Gemfile"),
        "token"    => token,
        "channels" => channels
      }
    end

    def optional_params
      {}.tap do |hash|
        hash['filetype']        = @filetype        if @filetype
        hash['filename']        = @filename        if @filename
        hash['title']           = @title           if @title
        hash['initial_comment'] = @initial_comment if @initial_comment
      end
    end

    def params
      required_params.merge(optional_params)
    end

    def endpoint
      domain.tap do |uri|
        uri.path = '/api/files.upload'
      end
    end
  end
end
