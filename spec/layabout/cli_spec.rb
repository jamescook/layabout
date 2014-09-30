require_relative '../spec_helper.rb'
require_relative '../../lib/layabout/cli.rb'

describe Layabout::CLI, vcr: true do
  describe '#run' do
    let(:stdin) { StringIO.new }

    before do
      subject.output = StringIO.new
      subject.input  = stdin
    end

    context 'given the upload command' do
      subject { described_class.new(['upload', '--file', 'spec/fixtures/upload_test.txt', '--channel', 'C026VKGP7']) }

      it 'succeeds' do
        expect{ subject.run }.to exit_with_status(:success)
      end
    end

    context 'given the users command' do
      subject { described_class.new(['users']) }

      it 'succeeds' do
        expect{ subject.run }.to exit_with_status(:success)
      end
    end

    context 'given the channels command' do
      subject { described_class.new(['channels']) }

      it 'succeeds' do
        expect{ subject.run }.to exit_with_status(:success)
      end
    end

    context 'given some text to say in a channel' do
      subject { described_class.new(['say', '--channel', 'ruby', '--username', 'Karl Childers']) }

      before do
        stdin.puts "hello world"
        stdin.rewind
      end

      it 'succeeds' do
        expect{ subject.run }.to exit_with_status(:success)
      end
    end

    context 'given auth test' do
      subject { described_class.new(['auth_test']) }

      it 'tests auth' do
        expect{ subject.run }.to exit_with_status(:success)
      end
    end
  end
end
