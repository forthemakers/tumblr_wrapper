class TumblrWrapper::Resource
  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def validate_oauth
    raise TumblrWrapper::OauthNeeded unless access_token
  end

  def validate_present(key, parameters)
    raise TumblrWrapper::MissingRequiredParameter, key unless parameters[key]
  end

  def validate_not_present(key, parameters)
    raise TumblrWrapper::InvalidParameter, key if parameters[key]
  end
end
