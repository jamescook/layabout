require_relative '../spec_helper.rb'
require_relative '../../lib/layabout/file_list.rb'

describe Layabout::FileList, vcr: true do
  describe '#list' do
    subject { described_class.new(count: 1) }
    it 'returns a list of Layabout::Slack::File' do
      expect(subject.list.first).to be_an_instance_of(Layabout::Slack::File)
    end
  end
end
