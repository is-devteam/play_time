# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'play_time/version'

Gem::Specification.new do |spec|
  spec.name          = "play_time"
  spec.version       = PlayTime::VERSION
  spec.authors       = ["Yuki Nishijima and Trevor John"]
  spec.email         = ["pair+tjohn+ynishijima@pivotal.io"]
  spec.summary       = %q{PlayTime is a gem for uploading apks to the Google Play Store}
  spec.description   = %q{More to come}
  spec.homepage      = "https://github.com/is-devteam/play_time"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'google-api-client', '~> 0.7'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
