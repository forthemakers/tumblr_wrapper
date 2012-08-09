# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tumblr_wrapper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["rheaton"]
  gem.email         = ["rachelmheaton@gmail.com"]
  gem.description   = %q{ruby wrapper for tumblr api}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.name          = "tumblr_wrapper"
  gem.require_paths = ["lib"]
  gem.version       = TumblrWrapper::VERSION
  gem.add_development_dependency 'spork'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'oauth'
  gem.add_dependency 'faraday'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'rake'
  gem.add_dependency 'simple_oauth'
end
