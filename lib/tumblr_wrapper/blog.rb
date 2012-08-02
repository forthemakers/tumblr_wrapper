class TumblrWrapper::Blog < TumblrWrapper::BlogResource
  ##
  # Required parameters: N/A
  # http://www.tumblr.com/docs/en/api/v2#blog-info
  def info
    http_get('info')
  end

  ##
  # Required parameters: N/A
  # http://www.tumblr.com/docs/en/api/v2#blog-followers
  def followers(parameters={})
    http_get('followers', {signed: true}, parameters)
  end

  ##
  # Required parameters: N/A
  # http://www.tumblr.com/docs/en/api/v2#posts
  def posts(parameters={})
    # for some reason the / is needed for this endpoint... -RH
    http_get('posts/', {signed: false}, parameters)
  end
end
