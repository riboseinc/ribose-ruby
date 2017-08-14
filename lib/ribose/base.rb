module Ribose
  class Base
    def initialize(attributes = {})
      @attributes = attributes
      extract_base_attributes
      extract_local_attributes
    end

    private

    attr_reader :resource_id, :attributes

    # Extract Local Attributes
    #
    # This hook method let us extract sub-class specific attributes
    # And the way to do it is pretty simple, we only need to override
    # this method and extract the keys from the attributes hash. For
    # exmaple if `attributes` contains a has key `space_id` and we
    # want to extract it to a sub-class then we can do it as follow
    #
    #   def extract_local_attributes
    #     @space_id = attributes.delete(:space_id)
    #   end
    #
    def extract_local_attributes; end

    def extract_base_attributes
      @resource_id = attributes.delete(:resource_id)
    end
  end
end
