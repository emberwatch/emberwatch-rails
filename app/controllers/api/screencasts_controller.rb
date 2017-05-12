module Api
  class ScreencastsController < BaseController
    include Concerns::ResourceController

    self.resource_scope = ::Screencast
  end
end
