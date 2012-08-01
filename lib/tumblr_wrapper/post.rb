class TumblrWrapper::Post < TumblrWrapper::BlogResource
  ##
  # Required parameters: :type
  # http://www.tumblr.com/docs/en/api/v2#posting
  def create(parameters = {})
    validate_present(:type, parameters)
    validate_not_present(:id, parameters)

    oauth_request('post', :post, parameters)
  end

  ##
  # Required parameters: :id
  # http://www.tumblr.com/docs/en/api/v2#editing
  def update(parameters = {})
    validate_present(:id, parameters)
    oauth_request('post/edit', :post, parameters)
  end

  ##
  # Required parameters: :id
  # http://www.tumblr.com/docs/en/api/v2#editing
  def delete(parameters = {})
    validate_present(:id, parameters)
    oauth_request('post/delete', :post, parameters)
  end
end
