module Ribose
  class Error < StandardError
    def initialize(response = nil)
      @response = response
      super
    end

    def self.from_response(response)
      status = response[:status].to_i
      if klass = case status
                 when 400 then Ribose::BadRequest
                 when 401 then Ribose::Unauthorized
                 when 403 then Ribose::Forbidden
                 when 404 then Ribose::NotFound
                 when 422 then Ribose::UnprocessableEntity
                 when 500..599 then Ribose::ServerError
                 end

        klass.new(response)
      end
    end
  end

  class BadRequest < Error; end
  class Unauthorized < Error; end
  class Forbidden < Error; end
  class NotFound < Error; end
  class UnprocessableEntity < Error; end
  class ServerError < Error; end
end
