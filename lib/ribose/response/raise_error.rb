require "ribose/error"

module Ribose
  module Response
    class RaiseError < Faraday::Response::Middleware
      def on_complete(response)
        if error = Ribose::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
