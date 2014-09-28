# Layabout - Slack API Toolbelt

[![Build Status](https://img.shields.io/travis/jamescook/layabout/master.svg?style=flat)](https://travis-ci.org/jamescook/layabout)
[![Code Climate](https://codeclimate.com/github/jamescook/layabout/badges/gpa.svg?style=flat)](https://codeclimate.com/github/jamescook/layabout)

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
Layabout.upload('/path/to/a/silly.gif', 'C234546')  # You must specify the channel ID ...
Layabout.channels                                   # Return a list of channels for your team
Layabout.users                                      # Return a list of users for your team
```
