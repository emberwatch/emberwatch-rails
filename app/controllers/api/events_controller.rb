module Api
  class EventsController < BaseController
    include Concerns::ResourceController

    self.resource_scope = ::Event
  end
end
