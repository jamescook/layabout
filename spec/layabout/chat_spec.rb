require_relative '../spec_helper.rb'
require_relative '../../lib/layabout/chat.rb'

describe Layabout::Chat, vcr: true do
  describe '#post' do
    subject { described_class.new(channel: 'C026VKGP7', text: 'hello, this is a test') }

    it 'submits a message' do
      expect(subject.post_message).to be_success
    end
  end
end
