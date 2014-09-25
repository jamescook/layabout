require 'forwardable'
require 'ostruct'

module Layabout
  module Slack
    class Channel
      extend Forwardable

      def_delegators :@attributes, :id, 
        :name, 
        :created,
        :creator,
        :is_archived,
        :is_member,
        :num_members,
        :topic,
        :purpose,
        :members,
        :last_read,
        :latest,
        :unread_count

      def initialize(attributes={})
        @attributes = OpenStruct.new(attributes)
      end

      def inspect
        "<Layabout::Slack::Channel id='#{id}' name='#{name}'>"
      end
    end
  end
end
