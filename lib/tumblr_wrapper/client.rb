class TumblrWrapper::Client
  attr_reader :consumer, :request_token
  def initialize
    @consumer = OAuth::Consumer.new(
      TumblrWrapper.consumer_key,
      TumblrWrapper.consumer_secret,
      site: 'http://www.tumblr.com'
    )
  end

  def authorize_url
    @request_token = @consumer.get_request_token
    @request_token.authorize_url
  end

  def access_token(oauth_verifier = nil)
    if oauth_verifier
      @access_token = request_token.get_access_token({:oauth_verifier => oauth_verifier})
    else
      @access_token
    end
  end

  def token
    @access_token.try(:token)
  end

  def secret
    @access_token.try(:secret)
  end
end
