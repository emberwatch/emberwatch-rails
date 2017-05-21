module Api
  module Podcast
    class FeedsController < BaseController
      include Concerns::ResourceController

      self.resource_scope = ::Podcast::Feed
    end
  end
end
