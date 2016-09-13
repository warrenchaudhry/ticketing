module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end

    def json_api_response
      res = JSON.parse(response.body, symbolize_names: true)
      return res[:data][:attributes]
    end
  end

  module HeadersHelpers
    def api_header
      request.headers['Accept'] = "application/vnd.api+json"
    end

    def api_response_format(format = Mime[:json])
      request.headers['Accept'] = "#{request.headers['Accept']},#{format}"
      request.headers['Content-Type'] = format.to_s
    end

    def api_authorization_header(token)
      request.headers['Authorization'] =  token
    end

    def include_default_accept_headers
      api_header
      api_response_format
    end
  end
end
