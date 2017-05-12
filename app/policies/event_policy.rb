class EventPolicy < ApplicationPolicy
  def permitted_params
    %i(date name site)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
