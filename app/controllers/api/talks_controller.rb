module Api
  class TalksController < BaseController
    include Concerns::ResourceController

    self.resource_scope = ::Talk
  end
end
