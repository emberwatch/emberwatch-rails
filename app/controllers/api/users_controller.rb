module Api
  class UsersController < BaseController
    include Concerns::ResourceController

    self.resource_scope = ::User
  end
end
