module Ribose
  class Base
    def initialize(attributes = {})
      @attributes = attributes
      extract_base_attributes
    end

    private

    attr_reader :resource_id, :attributes

    def extract_base_attributes
      @resource_id = attributes.delete(:resource_id)
    end
  end
end
