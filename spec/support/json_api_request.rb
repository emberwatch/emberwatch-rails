module JsonApiRequests
  def get(*args)
    super(*json_args(*args))
  end

  def post(*args)
    super(*json_args(*args))
  end

  def update(*args)
    super(*json_args(*args))
  end

  def patch(*args)
    super(*json_args(*args))
  end

  def put(*args)
    super(*json_args(*args))
  end

  def delete(*args)
    super(*json_args(*args))
  end

  def json_args(path, options = {})
    headers = options[:headers] || {}
    options[:headers] = headers.merge('CONTENT_TYPE' => 'application/vnd.api+json')
    options[:params]  = dasherize_keys(options[:params]).to_json if options.has_key?(:params)
    [path, options]
  end

  # dasherize all keys of the request recursively
  #
  def dasherize_keys(data)
    return nil if data.nil?
    return data.map { |obj| dasherize_keys obj } if data.is_a? Array
    if data.is_a? Hash
      return Hash[data.map {|k, v| [k.to_s.dasherize, dasherize_keys(v)] }]
    end
    return data
  end
end

RSpec.configure do |config|
  config.include JsonApiRequests, type: :request
end
