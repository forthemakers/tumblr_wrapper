module TumblrWrapper::HTTP
  def http_get(path, opts={signed: false}, params={})
    url = "#{uri}/#{path}"
    if opts[:signed]
      validate_oauth
      blank?(params) ? access_token.get(url, {'Accept'=> accept}) : access_token.get("#{url}?#{encode_params(params)}", {'Accept'=> accept})
    else
      parameters = params.merge({api_key: TumblrWrapper.consumer_key})
      RestClient.get(url, params: parameters, accept: accept)
    end
  end

  def http_post(path,opts={signed: false}, body)
    url = "#{uri}/#{path}"
    if opts[:signed]
      validate_oauth
      access_token.post(url, body.to_json, {'Accept'=> accept, 'Content-Type' => content_type})
    else
      RestClient.post(url, body, accept: accept, content_type: content_type)
    end
  end

  private
  def encode_params(parameters_as_hash)
    str = parameters_as_hash.collect{|k,v| "#{k}=#{v}"}.join('&')
    URI.escape(str)
  end

  def content_type
    'application/json'
  end

  def accept
    'application/json'
  end

  def uri
    raise NotImplementedError
  end

  def blank?(thing)
    thing.nil? || thing.length == 0
  end
end
