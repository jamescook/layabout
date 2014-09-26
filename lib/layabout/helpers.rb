require_relative './chat.rb'
require_relative './channels.rb'
require_relative './file_upload.rb'

module Layabout
  module Helpers
    def say(message, channel, options={})
      options = options.dup.merge(text: message, channel: channel)
      Chat.new(options).post_message
    end

    def channels(options={})
      Channels.new.list
    end

    def upload(filepath, channels, options={})
      options = options.dup.merge(filepath: filepath, channels: channels)
      FileUpload.new(options).upload
    end
  end
end
