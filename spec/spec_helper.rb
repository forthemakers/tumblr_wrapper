require 'rubygems'
require 'spork'

Spork.prefork do
  require 'rspec'
  require 'vcr'
  require 'webmock'
  require 'tumblr_wrapper'

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/vcr_cassettes'
    c.hook_into :webmock
  end

  RSpec.configure do |config|
    config.mock_with :rspec
  end
end
