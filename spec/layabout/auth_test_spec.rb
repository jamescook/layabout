require_relative '../spec_helper.rb'
require_relative '../../lib/layabout/auth_test.rb'

describe Layabout::AuthTest, vcr: true do
  describe '#get' do
    subject { described_class.new }

    it 'tests auth' do
      expect(subject.get).to be_success
    end
  end
end
