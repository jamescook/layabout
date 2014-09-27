# Layabout - Slack API Toolbelt

![travis] (https://travis-ci.org/jamescook/layabout.svg)

### Configuration
```
Layabout.configure do |config|
  config.team  = 'isotope11'
  config.token = 'your-api-token'
 end
```

### Usage

```
Layabout.say('hello world', '#random')              # Posts a message
Layabout.join('#random')                            # Join a channel. You may also use a channel ID here
Layabout.leave('C234546')                           # Leave a channel by ID. Channel name does not work here
Layabout.upload('/path/to/a/silly.gif', 'C234546')  # You must specify the channel ID ...
Layabout.channels                                   # Return a list of channels for your team
Layabout.users                                      # Return a list of users for your team
```
