class ScreencastPolicy < ApplicationPolicy
  def permitted_params
    %i(title url date series price subtitle video)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
