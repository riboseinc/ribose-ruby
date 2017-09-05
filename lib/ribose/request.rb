require "faraday"
require "sawyer"

module Ribose
  class Request
    # Initialize a Request
    #
    # @param http_method [Symbol] HTTP verb as sysmbol
    # @param endpoint [String] The relative API endpoint
    # @param data [Hash] Attributes / Options as a Hash
    # @return [Ribose::Request]
    #
    def initialize(http_method, endpoint, **data)
      @data = data
      @endpoint = endpoint
      @http_method = http_method
    end

    # Make a HTTP Request
    #
    # @param options [Hash] Additonal options hash
    # @return [Sawyer::Resource]
    #
    def request(options = {})
      options[:query] = extract_query_options
      agent.call(http_method, api_endpoint, data, options).data
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

    attr_reader :data, :http_method

    def extract_query_options
      if data.is_a?(Hash)
        data.delete(:query) || {}
      end
    end

    def ribose_host
      Ribose.configuration.api_host
    end

    def api_endpoint
      URI::HTTPS.build(
        host: ribose_host,
        path: ["", @endpoint].join("/").squeeze("/"),
      )
    end

    def sawyer_options
      {
        links_parser: Sawyer::LinkParsers::Simple.new,
        faraday: Faraday.new(builder: custom_builder),
      }
    end

    def custom_builder
      if Ribose.configuration.debug_mode?
        Faraday::RackBuilder.new do |builder|
          builder.response :logger, nil, bodies: true
          builder.adapter Faraday.default_adapter
        end
      end
    end

    def agent
      @agent ||= Sawyer::Agent.new(ribose_host, sawyer_options) do |http|
        http.headers[:accept] = "application/json"
        http.headers[:content_type] = "application/json"
        http.headers["X-Indigo-Token"] = Ribose.configuration.api_token
        http.headers["X-Indigo-Email"] = Ribose.configuration.user_email
      end
    end
  end
end
