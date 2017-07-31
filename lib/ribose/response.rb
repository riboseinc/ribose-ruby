require "json"

module Ribose
  class Response
    def initialize(response)
      @response = response
    end

    def data
      if valid_response? && response.body
        JSON.parse(response.body)
      end
    end

    private

    attr_reader :response

    def valid_response?
      response.is_a?(Net::HTTPSuccess)
    end
  end
end
