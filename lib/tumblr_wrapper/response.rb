class TumblrWrapper::Response
  attr_reader :status, :meta
  def initialize(faraday_response)
    @faraday_response = faraday_response
    @status = faraday_response.status
    @response = faraday_response.body["response"]
    parse_meta
  end

  private
  def faraday_response
    @faraday_response
  end

  def response
    @response
  end

  def parse_meta
    resp = faraday_response.body["meta"] || {}
    @meta = resp.with_indifferent_access
  end

  def method_missing(meth, *args, &block)
    if response.keys.include?(meth.to_s)
      r = response[meth.to_s]
      r.respond_to?(:keys) ? r.with_indifferent_access : r
    else
      super
    end
  end
end