class Api
  attr_accessor :url

  def initialize
    @base_url = "#{API_URL}/api/#{API_VERSION}/"
  end

  def header_options options
    headers = { 
      "client_id" => CLIENT_ID,
      :content_type => "application/json"
    }
    headers["Authorization"] = "Token token=#{options[:auth_token]}" if options[:auth_token].present?
    headers
  end

  # Create an employee using a predefined XML template as a REST request.
  def get options
    return nil if validate_api_options(options)
    begin
      response = RestClient.get(get_uri(options), header_options(options))

      JSON.parse(response, :symbolize_names => true)
    rescue => e
      Rails.logger.error "Error: #{e}"
      nil
    end
  end

  # Encode the entire body as JSON
  def post options
    return nil if validate_api_options(options)
    begin
      request_body_map = options[:attributes].present? ? options[:attributes] : {}
      response = RestClient.post(get_uri(options),
                                request_body_map.to_json,
                                header_options(options))
      JSON.parse(response, :symbolize_names => true)
    rescue => e
      Rails.logger.error "Error: #{e}"
      nil
    end
  end

  def put options
    return nil if validate_api_options(options)
    begin
      request_body_map = options[:attributes].present? ? options[:attributes] : {}
      # PUT the entire record to update it
      response = RestClient.put(get_uri(options),
                               request_body_map.to_json,
                               header_options(options))
     JSON.parse(response, :symbolize_names => true)
    rescue => e
      Rails.logger.error "Error: #{e}"
      nil
    end
  end

  def delete options
    begin
      response = RestClient.delete(get_uri(options), header_options(options))
      
      JSON.parse(response, :symbolize_names => true)
    rescue => e
      Rails.logger.error "Error: #{e}"
      nil
    end
  end

  private

  def validate_api_options options
    options[:resource].blank?
  end

  def get_uri options
    @base_url + options[:resource]
  end

end