require "json"
require "ostruct"

module Ribose
  class Response
    def initialize(response)
      @response = response
    end

    def code
      response.code
    end

    def body
      response.body
    end

    def data
      serialized_response || []
    end

    private

    attr_reader :response

    def valid_response?
      response.is_a?(Net::HTTPSuccess)
    end

    def serialized_response
      if valid_response? && body
        JSON.parse(body, object_class: Ribose::Resource)
      end
    end
  end

  class Resource < OpenStruct; end
end
