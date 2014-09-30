require_relative '../spec_helper.rb'
require_relative '../../lib/layabout.rb'

describe Layabout, vcr: true do
  describe '.say' do
    context 'with a webhook token' do
      it 'posts a message' do
        expect(Layabout.say_with_webhook('hello', '2VyiZrFyVx4maiOvG3uae1RA')).to be_success
      end
    end

    context 'using the default chat api' do
      it 'posts a message' do
        expect(Layabout.say('hello', 'C026VKGP7', username: 'Annoying bot')).to be_success
      end
    end
  end

  describe '.upload' do
    it 'uploads a file' do
      expect(Layabout.upload('spec/fixtures/upload_test.txt', 'C026VKGP7')).to be_success
    end
  end

  describe '.channels' do
    it 'returns a list of channels' do
      channels = Layabout.channels
      expect(channels).to be_an_instance_of(Array)
      expect(channels.first).to be_an_instance_of(Layabout::Slack::Channel)
    end
  end

  describe '.channel_info' do
    it 'returns info about the specified channel' do
      expect(Layabout.channel_info('C029N15A8')).to be_an_instance_of(Layabout::Slack::Channel)
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
      users = Layabout.users
      expect(users).to be_an_instance_of(Array)
      expect(users.first).to be_an_instance_of(Layabout::Slack::User)
    end
  end
end
