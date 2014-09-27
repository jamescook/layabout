require_relative './chat.rb'
require_relative './channels.rb'
require_relative './file_upload.rb'
require_relative './users.rb'

module Layabout
  module Helpers
    def say(message, channel, options={})
      options = options.dup.merge(text: message, channel: channel)
      Chat.new(options).post_message
    end

    def channels(options={})
      Channels.new.list
    end

    def join(channel_name)
      Channels.new.join(channel_name)
    end

    def leave(channel_id)
      Channels.new.leave(channel_id)
    end

    def upload(filepath, channels, options={})
      options = options.dup.merge(filepath: filepath, channels: channels)
      FileUpload.new(options).upload
    end

    def users
      Users.new.list
    end
  end
end
