require_relative '../layabout.rb'
require_relative '../layabout/version.rb'
require_relative '../layabout/auth_test.rb'

module Layabout
  class CLI

    attr_reader :command, :options
    attr_accessor :input, :output

    def initialize(args)
      @args = args.dup
      @command = @args.first
      @options = @args[1..-1]
      @output  = STDOUT
      @input   = STDIN
      HTTPI.log = false
      configure_layabout
    end

    def run
      case command
      when 'help' then
        print_help
        exit 0
      when 'auth_test' then
        output.puts Layabout::AuthTest.new.get.body
        exit 0
      when 'say' then
        output.puts Layabout.say(read_option('message') || input.read, '#' + read_option('channel'), username: read_option('username')).body
        exit 0
      when 'channels' then
        output.puts Layabout.channels.map{|channel| channel.to_hash }
        exit 0
      when 'users' then
        output.puts Layabout.users.map{|user| user.to_hash }
        exit 0
      when 'upload' then
        output.puts Layabout.upload(read_option('file'), read_option('channel'))
        exit 0
      else
        print_help
        exit 1
      end
    end

    private

    def print_help
      output.puts <<EOF
Layabout is a tool for communicating with the Slack API
Version: #{Layabout::VERSION}

  Usage:"
    layabout COMMAND [options...]

  Examples:"
    export SLACK_TEAM=your-slack-team
    export SLACK_API_TOKEN=your-api-token

    echo 'hello world' | layabout say --channel ruby
    layabout upload --file /path/to/kitten.gif --channel ruby

  Further information:
    http://github.com/jamescook/layabout
EOF
    end

    def configure_layabout
      Layabout.configure do |c|
        c.token ||= ENV['SLACK_API_TOKEN']
        c.team  ||= ENV['SLACK_TEAM']
      end
    end

    def read_option(key)
      idx = options.index("--#{key}")
      return options[idx+1] if idx
    end
  end
end
