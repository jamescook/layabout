# Layabout - Slack API Toolbelt

[![Build Status](https://img.shields.io/travis/jamescook/layabout/master.svg?style=flat)](https://travis-ci.org/jamescook/layabout)
[![Code Climate](https://codeclimate.com/github/jamescook/layabout/badges/gpa.svg?style=flat)](https://codeclimate.com/github/jamescook/layabout)
[![Test Coverage](https://codeclimate.com/github/jamescook/layabout/badges/coverage.svg)](https://codeclimate.com/github/jamescook/layabout)
[![Gem Version](https://badge.fury.io/rb/layabout.svg)](http://badge.fury.io/rb/layabout)

### Configuration
```
Layabout.configure do |config|
  config.team  = 'isotope11'
  config.token = 'your-api-token'
 end
```

### Usage

```
Layabout.say('hello world', '#random')              # Posts a message via Chat API
Layabout.say_with_webhook('howdy', 'special-token')  # Posts a message using a incoming webhook
Layabout.join('#random')                            # Join a channel. You may also use a channel ID here
Layabout.leave('C234546')                           # Leave a channel by ID. Channel name does not work here
Layabout.upload('/path/to/a/silly.gif', 'C234546')  # Upload a file. You must specify the channel ID ...
Layabout.channels                                   # Return a list of channels for your team
Layabout.users                                      # Return a list of users for your team
```


### Command-line usage

```
  Usage:
    layabout COMMAND [options...]

  Examples:
    export SLACK_TEAM=your-slack-team
    export SLACK_API_TOKEN=your-api-token

    echo 'hello world' | layabout say --channel ruby
    layabout upload --file /path/to/kitten.gif --channel C234546
```
