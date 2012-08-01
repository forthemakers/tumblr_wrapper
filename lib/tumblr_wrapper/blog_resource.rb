class TumblrWrapper::BlogResource < TumblrWrapper::Resource
  attr_reader :hostname, :access_token

  def initialize(base_hostname, access_token=nil)
    @hostname = base_hostname
    super(access_token)
  end

  def blog
    TumblrWrapper::Blog.new(@hostname, access_token)
  end

  def post
    TumblrWrapper::Post.new(@hostname, access_token)
  end

  protected
  def oauth_request(path, method_type = :get, body = {})
    validate_oauth

    url = "#{endpoint}/blog/#{hostname}/#{path}"
    if parameters.present?
      access_token.request(method_type, url, body)
    else
      access_token.request(method_type, url)
    end
  end

  def request(path, method_type = :get, parameters = {})
    parameters.merge!({ api_key: TumblrWrapper.consumer_key })
    params = (method_type == :get) ? { params: parameters } : parameters

    TumblrWrapper::RestClient.send(method_type, "#{endpoint}/blog/#{hostname}/#{path}", params)
  end
end
