class TumblrWrapper::Client
  attr_reader :access_token, :request_token

  def authorize_url
    @request_token = consumer.get_request_token({:exclude_callback => true})
    @request_token.authorize_url
  end

  def request_access_token(oauth_verifier)
    token = request_token.get_access_token({:oauth_verifier => oauth_verifier})
    @access_token = {
      consumer_key: TumblrWrapper.consumer_key,
      consumer_secret: TumblrWrapper.consumer_secret,
      token: token.token,
      token_secret: token.secret
    }
  end

  def build_request_token(token, secret)
    @request_token = OAuth::RequestToken.new(consumer, token, secret)
  end

  def build_access_token(token, secret)
    @access_token = {
      consumer_key: TumblrWrapper.consumer_key,
      consumer_secret: TumblrWrapper.consumer_secret,
      token: token,
      token_secret: secret }
  end

  def consumer
    @consumer ||= OAuth::Consumer.new(
      TumblrWrapper.consumer_key,
      TumblrWrapper.consumer_secret,
      site: 'http://www.tumblr.com'
    )
  end
end
