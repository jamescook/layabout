require_relative '../spec_helper.rb'

describe Layabout::Configuration do
  describe '#valid?' do

    before do
      subject.token = "1234567890"
      subject.team  = "isotope11"
    end

    it 'is true if the team and token are present' do
      expect(subject).to be_valid
    end
  end
end
