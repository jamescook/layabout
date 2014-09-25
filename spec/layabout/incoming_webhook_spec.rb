require_relative '../spec_helper.rb'
require_relative '../../lib/layabout/incoming_webhook.rb'

describe Layabout::IncomingWebhook, vcr: true do
  describe '#post' do
    before do
      Layabout.configure do |c|
        c.team = "isotope11"
      end
    end

    subject { described_class.new(token: '2VyiZrFyVx4maiOvG3uae1RA', message: 'hello') }

    it 'submits a message' do
      expect(subject.post).to be_success
    end
  end
end
