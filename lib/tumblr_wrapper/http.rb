module TumblrWrapper::HTTP

  def http_get(path, opts={signed: false}, params={})
    validate_oauth if opts[:signed]
    connection = Faraday.new TumblrWrapper.endpoint do |conn|
      conn.request :oauth, access_token if opts[:signed]
      conn.request :json
      conn.adapter Faraday.default_adapter
    end
    if opts[:signed]
      connection.get(long_path(path) + encode_params(params))
    else
      parameters = params.merge({api_key: TumblrWrapper.consumer_key})
      connection.get(long_path(path), parameters)
    end
  end

  def http_post(path,opts={signed: false}, body)
    validate_oauth if opts[:signed]
    connection = Faraday.new TumblrWrapper.endpoint do |conn|
      conn.request :oauth, access_token if opts[:signed]
      conn.adapter Faraday.default_adapter
    end

    connection.post do |request|
      request.url long_path(path)
      request.headers['Accept'] = accept
      request.headers['Content-Type'] = content_type
      request.body = body.to_json
    end
  end

  private
  def encode_params(parameters_as_hash)
    if blank?(parameters_as_hash)
      ""
    else
      str = parameters_as_hash.collect{|k,v| "#{k}=#{v}"}.join('&')
      "?" + URI.escape(str)
    end
  end

  def content_type
    'application/json'
  end

  def accept
    'application/json'
  end

  def long_path(path)
    raise NotImplementedError
  end

  def blank?(thing)
    thing.nil? || thing.length == 0
  end
end
