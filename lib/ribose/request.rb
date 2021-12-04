module Ribose
  class Request
    DEFAULT_CONTENT_TYPE = "application/json"

    # Initialize a Request
    #
    # @param http_method [Symbol] HTTP verb as sysmbol
    # @param endpoint [String] The relative API endpoint
    # @param data [Hash] Attributes / Options as a Hash
    # @return [Ribose::Request]
    #
    def initialize(http_method, endpoint, data = {})
      @data = data
      @endpoint = endpoint
      @http_method = http_method
      @client = find_suitable_client
    end

    # Make a HTTP Request
    #
    # @param options [Hash] Additonal options hash
    # @return [Sawyer::Resource]
    #
    def request(options = {})
      parsable = extract_config_option(:parse) != false
      options[:query] = extract_config_option(:query) || {}

      response = agent.call(http_method, api_endpoint, data, options)
      update_client_headers(response.headers)

      parsable == true ? response.data : response
    end

    # Make a HTTP GET Request
    #
    # @param endpoint [String] The relative API endpoint
    # @param options [Hash] The additional query params
    # @return [Sawyer::Resource]
    #
    def self.get(endpoint, options = {})
      new(:get, endpoint, options).request
    end

    # Make a HTTP POST Request
    #
    # @param endpoint [String] The relative API endpoint
    # @param data [Hash] The request data as a Hash
    # @return [Sawyer::Resource]
    #
    def self.post(endpoint, data)
      new(:post, endpoint, data).request
    end

    # Make a HTTP PUT Request
    #
    # @param endpoint [String] The relative API endpoint
    # @param data [Hash] The request data as a Hash
    # @return [Sawyer::Resource]
    #
    def self.put(endpoint, data)
      new(:put, endpoint, data).request
    end

    # Make a HTTP DELETE Request
    #
    # @param endpoint [String] The relative API endpoint
    # @return [Sawyer::Resource]
    #
    def self.delete(endpoint, options = {})
      new(:delete, endpoint, options).request
    end

    private

    attr_reader :client, :data, :http_method

    def ribose_host
      Ribose.configuration.api_host
    end

    def extract_config_option(key)
      if data.is_a?(Hash)
        data.delete(key.to_sym)
      end
    end

    def find_suitable_client
      client = extract_config_option(:client) || Ribose.configuration.client
      client.is_a?(Ribose::Client) ? client : raise(Ribose::Unauthorized)
    end

    def require_auth_headers?
      extract_config_option(:auth_header) != false
    end

    def custom_content_headers
      extract_config_option(:headers) || {}
    end

    def api_endpoint
      URI::HTTPS.build(
        host: ribose_host,
        path: ["", @endpoint].join("/").squeeze("/"),
      )
    end

    def sawyer_options
      faraday_options = { builder: custom_rack_builder }
      unless Ribose.configuration.verify_ssl?
        faraday_options.merge!(ssl: Faraday::SSLOptions.new(
          false, nil, nil, OpenSSL::SSL::VERIFY_NONE
        ))
      end

      {
        faraday: Faraday.new(faraday_options),
        links_parser: Sawyer::LinkParsers::Simple.new,
      }
    end

    def custom_rack_builder
      Faraday::RackBuilder.new do |builder|
        Ribose.configuration.add_default_middleware(builder)
      end
    end

    def agent
      @agent ||= Sawyer::Agent.new(ribose_host, sawyer_options) do |http|
        set_content_type(http.headers)
        set_devise_specific_headers(http.headers)

        if require_auth_headers?
          http.headers["X-Indigo-Token"] = client.api_token
          http.headers["X-Indigo-Email"] = client.api_email
        end
      end
    end

    def update_client_headers(headers)
      client.uid = headers["uid"]
      client.client_id = headers["client"]
      client.access_token = headers["access-token"]
    end

    def set_content_type(headers)
      headers[:content_type] = DEFAULT_CONTENT_TYPE
      headers[:accept] = custom_content_headers.fetch(
        :accept, DEFAULT_CONTENT_TYPE
      )
    end

    def set_devise_specific_headers(headers)
      headers["uid"] = client.uid
      headers["client"] = client.client_id
      headers["access-token"] = client.access_token
    end
  end
end
