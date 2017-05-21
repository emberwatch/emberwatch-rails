class TutorialPolicy < ApplicationPolicy
  def permitted_params
    %i(title urls date code date_updated date_created versions demo)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
