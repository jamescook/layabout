require 'forwardable'
require 'ostruct'

module Layabout
  module Slack
    class User
      extend Forwardable

      def_delegators :@attributes, :id, 
        :name,
        :deleted,
        :color,
        :first_name,
        :last_name,
        :real_name,
        :email,
        :skype,
        :phone,
        :image_24,
        :image_32,
        :image_48,
        :image_72,
        :image_192,
        :is_admin,
        :is_owner,
        :has_files

      def initialize(attributes={})
        # 'Flatten' the hash. No need for the nested profile.
        attributes = attributes.dup
        if attributes.key? 'profile'
          attributes.merge! attributes['profile']
          attributes.delete 'profile'
        end
        @attributes = OpenStruct.new(attributes)
      end

      def inspect
        "<Layabout::Slack::User id='#{id}' name='#{name}'>"
      end
    end
  end
end
