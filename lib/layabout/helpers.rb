require_relative './chat.rb'
require_relative './channel_list.rb'
require_relative './channel_action.rb'
require_relative './file_upload.rb'
require_relative './users.rb'
require_relative './incoming_webhook.rb'

module Layabout
  module Helpers
    def say(message, channel, options={})
      options = options.dup.merge(text: message, channel: channel)
      Chat.new(options).post_message
    end

    def say_with_webhook(message, token)
      IncomingWebhook.new(message: message, token: token).post
    end

    def channels(options={})
      ChannelList.new.list
    end

    def channel_info(channel_id)
      ChannelAction.new(channel_id).info
    end

    def join(channel_name)
      ChannelAction.new(channel_name, key: 'name').join
    end

    def leave(channel_id)
      ChannelAction.new(channel_id).leave
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
