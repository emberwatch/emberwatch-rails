module Api
  class PeopleController < BaseController
    include Concerns::ResourceController

    self.resource_scope = ::Person
  end
end
