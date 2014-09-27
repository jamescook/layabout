require_relative '../spec_helper.rb'
require_relative '../../lib/layabout.rb'

describe Layabout, vcr: true do
  describe '.say' do
    it 'posts a message' do
      expect(Layabout.say('hello', 'C026VKGP7')).to be_success
    end
  end

  describe '.upload' do
    it 'uploads a file' do
      expect(Layabout.upload('spec/fixtures/upload_test.txt', 'C026VKGP7')).to be_success
    end
  end

  describe '.channels' do
    it 'returns a list of channels' do
      expect(Layabout.channels).to be_an_instance_of(Array)
      expect(Layabout.channels.first).to be_an_instance_of(Layabout::Slack::Channel)
    end
  end

  describe '.join' do
    it 'joins the specified channel and returns an instance of Channel' do
      expect(Layabout.join('#ruby')).to be_an_instance_of(Layabout::Slack::Channel)
    end
  end

  describe '.leave' do
    it 'leave the specified channel' do
      expect(Layabout.leave('C026VKGP7')).to be_success
    end
  end

  describe '.users' do
    it 'returns a list of users' do
      expect(Layabout.users).to be_an_instance_of(Array)
      expect(Layabout.users.first).to be_an_instance_of(Layabout::Slack::User)
    end
  end
end
