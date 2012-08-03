class TumblrWrapper::Resource
  include TumblrWrapper::Validators
  include TumblrWrapper::HTTP

  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end
end
