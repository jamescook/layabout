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
Layabout.upload('/path/to/a/silly.gif', 'C234546')  # You must specify the channel ID ...
Layabout.channels                                   # Return a list of channels
```
