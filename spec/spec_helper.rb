require 'rubygems'
require 'spork'

Spork.prefork do
  require 'rspec'
  require 'tumblr_wrapper'

  RSpec.configure do |config|
    config.mock_with :rspec
  end
end
