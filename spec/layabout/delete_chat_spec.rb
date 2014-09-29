require_relative '../spec_helper.rb'
require_relative '../../lib/layabout/delete_chat.rb'

describe Layabout::DeleteChat, vcr: true do
  describe '#delete' do
    subject { described_class.new(channel: 'C026VKGP7', timestamp: 'p1411646714.000002') }

    it 'deletes the message' do
      expect(subject.delete).to be_success
    end
  end
end
