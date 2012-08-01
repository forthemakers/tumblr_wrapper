require 'json'
require 'oauth'
require 'rest-client'
require "tumblr_wrapper/version"
require "tumblr_wrapper/validators"
require "tumblr_wrapper/http"
require "tumblr_wrapper/client"
require "tumblr_wrapper/resource"
require "tumblr_wrapper/blog_resource"
require "tumblr_wrapper/blog"
require "tumblr_wrapper/post"

module TumblrWrapper
  ENDPOINT = 'http://api.tumblr.com/v2'
  OAUTH_ENPOINT = 'http://www.tumblr.com'

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
