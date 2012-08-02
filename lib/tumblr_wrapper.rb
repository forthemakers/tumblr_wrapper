require 'json'
require 'oauth'
require 'faraday'
require 'faraday_middleware'

require "tumblr_wrapper/version"
require "tumblr_wrapper/validators"
require "tumblr_wrapper/http"
require "tumblr_wrapper/client"
require "tumblr_wrapper/resource"
require "tumblr_wrapper/blog_resource"
require "tumblr_wrapper/blog"
require "tumblr_wrapper/post"

module TumblrWrapper
  ENDPOINT = 'http://api.tumblr.com'
  OAUTH_ENPOINT = 'http://www.tumblr.com'
  API_VERSION = 'v2'

  def self.consumer_key=(key)
    @@consumer_key = key
  end

  def self.consumer_key
    @@consumer_key
  end

  def self.consumer_secret=(secret)
    @@consumer_secret = secret
  end

  def self.consumer_secret
    @@consumer_secret
  end

  def self.oauth_endpoint
    OAUTH_ENDPOINT
  end

  def self.endpoint
    ENDPOINT
  end

  def self.version
    API_VERSION
  end

  class NoAccessToken < StandardError
    def initialize(message = "Oauth request. Set access_token")
      super(message)
    end
  end

  class MissingRequiredParameter < StandardError
  end

  class InvalidParameter < StandardError
  end
end
