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

  def uri
    "#{TumblrWrapper.endpoint}/blog/#{hostname}"
  end

end
