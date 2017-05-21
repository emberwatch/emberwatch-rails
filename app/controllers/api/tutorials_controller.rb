module Api
  class TutorialsController < BaseController
    include Concerns::ResourceController

    self.resource_scope = ::Tutorial
  end
end
