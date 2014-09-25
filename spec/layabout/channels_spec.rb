require_relative '../spec_helper.rb'
require_relative '../../lib/layabout/channels.rb'

describe Layabout::Channels, vcr: true do

  describe '#list' do
    it 'returns a list of Layabout::Slack::Channel' do
      expect(subject.list.first).to be_an_instance_of(Layabout::Slack::Channel)
    end
  end

  describe '#info' do
    it 'returns a Layabout::Slack::Channel' do
      expect(subject.info('C029N15A8')).to be_an_instance_of(Layabout::Slack::Channel)
    end
  end

  describe '#join' do
    it 'returns a success response' do
      expect(subject.join('#ruby')).to be_success
    end
  end

  describe '#leave' do
    it 'returns a success response' do
      expect(subject.leave('C026K09CS')).to be_success
    end
  end
end
