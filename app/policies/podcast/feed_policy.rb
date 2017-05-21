module Podcast
  class FeedPolicy < ApplicationPolicy
    def permitted_params
      %i(url)
    end

    class Scope < Scope
      def resolve
        scope
      end
    end
  end
end
