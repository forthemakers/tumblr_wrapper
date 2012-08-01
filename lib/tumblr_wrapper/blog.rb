class TumblrWrapper::Blog < TumblrWrapper::BlogResource
  ##
  # Required parameters: N/A
  # http://www.tumblr.com/docs/en/api/v2#blog-info
  def info
    request('info')
  end

  ##
  # Required parameters: N/A
  # http://www.tumblr.com/docs/en/api/v2#blog-followers
  def followers(parameters={})
    oauth_request('followers', parameters)
  end

  ##
  # Required parameters: N/A
  # http://www.tumblr.com/docs/en/api/v2#posts
  def posts(parameters={})
    request('posts', parameters)
  end
end
