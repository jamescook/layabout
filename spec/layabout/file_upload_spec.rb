require_relative '../spec_helper.rb'
require_relative '../../lib/layabout/file_upload.rb'

describe Layabout::FileUpload, vcr: true do
  describe '#upload' do
    subject { described_class.new(filepath: "spec/fixtures/upload_test.txt", channels: "C026VKGP7") }

    it 'uploads a file' do
      expect(subject.upload).to be_success
    end
  end
end
