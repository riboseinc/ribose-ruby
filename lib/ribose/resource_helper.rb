module Ribose
  module ResourceHelper
    # Resource
    #
    # This is the key interface for any resource and every single
    # resource should implement this method.Ideally this should
    # reflect resource name in singular form, eg: +space+.
    #
    # Once we've this method implemented then this module will try
    # to auto-generate all of the related helper methods, but if
    # we need something different that the standard format then we
    # can always overirde that in those classes.
    #
    # @return resrouce [String] The singular form of the Resource
    def resource
      raise NotImplementedError
    end

    # Resource Id
    #
    # The id for the key component of any of the classes in
    # Ribose module, ideally we will have that one as default
    # attribtue to the base class, but we can override it if
    # necessary.
    #
    # @return resource_id [String] The id/uuid for a Resource
    def resource_id
      raise NotImplementedError
    end

    # Resources
    #
    # The plural version of the resoruce name, ideally we will
    # use this one to to identify an array or resources.
    #
    # @return resources [String] The plural form of the Resource
    def resources
      [resource, "s"].join
    end

    # Resource Key
    #
    # The resource key is the key that we use to build any of
    # the post/put request body, and ideally it's the resoruce
    # value, but occassionally it might be diffrent for any of
    # the reason, so this method will keep that on portable.
    #
    # @return resource_key [String] The key to build a request
    def resource_key
      resource
    end

    # Resources Path
    #
    # This represent a restfull resoruce path, and internally
    # this will be used to build the the api endpoint path for
    # any specifies resources.
    #
    # Based on the Ribose API structure it's pretty similiar
    # to the resources value with some minor exception of the
    # nested resoruces, so we are keeping the +resources+ as
    # default but we can override this when necessary.
    #
    # @return resource_path [String] The endpoit for Resources
    def resources_path
      resources
    end

    # Resource Path
    #
    # This represent a single resource in a Restfull API. In
    # Ribose API structure, it's `resources/:id`, so we will
    # use that one as default. If we need something different
    # then please override this method.
    #
    # @return resoruce_path [String] The Single Resource path
    def resource_path
      [resources_path, resource_id].join("/")
    end
  end
end
