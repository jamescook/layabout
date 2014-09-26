require 'forwardable'
require 'ostruct'

module Layabout
  module Slack
    class File
      extend Forwardable

      def_delegators :@attributes, 
        :id,
        :timestamp,
        :name,
        :title,
        :mimetype,
        :filetype,
        :pretty_type,
        :user,
        :mode,
        :editable,
        :is_external,
        :external_type,
        :size,
        :url,
        :url_download,
        :url_private,
        :url_private_download,
        :thumb_64,
        :thumb_80,
        :thumb_360,
        :thumb_360_gif,
        :thumb_360_w,
        :thumb_360_h,
        :permalink,
        :edit_link,
        :preview,
        :preview_highlight,
        :lines,
        :lines_more,
        :is_public,
        :public_url_shared,
        :channels,
        :groups,
        :initial_comment,
        :num_stars,
        :is_starred

      def initialize(attributes={})
        @attributes = OpenStruct.new(attributes)
      end

      def inspect
        "<Layabout::Slack::File id='#{id}' name='#{name}'>"
      end
    end
  end
end
