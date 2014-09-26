lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'layabout/version'

Gem::Specification.new do |spec|
  spec.name          = "layabout"
  spec.version       = Layabout::VERSION
  spec.authors       = ["James Cook"]
  spec.email         = ["jcook.rubyist@gmail.com"]
  spec.description   = %q{slack.com API toolbelt}
  spec.summary       = %q{Chat, upload files, set channel topics, send direct messages, and more via the Slack API}
  spec.homepage      = "https://github.com/jamescook/layabout"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httpi",               "~> 2.1.1"
  spec.add_dependency "multipart-post",      "~> 1.1.0"
end
