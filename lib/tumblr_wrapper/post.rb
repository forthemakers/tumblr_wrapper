class TumblrWrapper::Post < TumblrWrapper::BlogResource
  ##
  # Required parameters: :type
  # http://www.tumblr.com/docs/en/api/v2#posting
  def create(parameters = {})
    validate_present(:type, parameters)
    validate_not_present(:id, parameters)

    http_post('post', parameters)
  end

  ##
  # Required parameters: :id
  # http://www.tumblr.com/docs/en/api/v2#editing
  def update(parameters = {})
    validate_present(:id, parameters)
    http_post('post/edit', parameters)
  end

  ##
  # Required parameters: :id
  # http://www.tumblr.com/docs/en/api/v2#editing
  def delete(parameters = {})
    validate_present(:id, parameters)
    http_post('post/delete', parameters)
  end
end
