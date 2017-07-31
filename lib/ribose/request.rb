require "uri"
require "net/http"
require "ribose/response"

module Ribose
  class Request
    def initialize(http_method, endpoint, **attributes)
      @http_method = http_method
      @endpoint = endpoint
      @attributes = attributes
    end

    def run
      Ribose::Response.new(send_http_request)
    end

    def self.get(endpoint)
      new(:get, endpoint).run
    end

    private

    attr_reader :endpoint, :http_method, :attributes

    def send_http_request
      Net::HTTP.start(*net_http_options) do |http|
        http.request(http_request)
      end
    end

    def net_http_options
      [uri.host, uri.port, use_ssl: true]
    end

    def uri
      URI::HTTPS.build(
        host: Ribose.configuration.api_host,
        path: ["", endpoint].join("/").squeeze("/"),
      )
    end

    def http_request
      @http_request ||= constanize_http_class.new(uri).tap do |request|
        set_request_body!(request)
        set_request_headers!(request)
      end
    end

    def constanize_http_class
      Object.const_get("Net::HTTP::#{http_method.capitalize}")
    end

    def set_request_headers!(request)
      request.initialize_http_header(
        "Accept" => "application/json",
        "X-Indigo-Token" => Ribose.configuration.api_token,
        "X-Indigo-Email" => Ribose.configuration.user_email,
      )
    end

    def set_request_body!(request)
      unless attributes.empty?
        request.body = attributes.to_json
      end
    end
  end
end
