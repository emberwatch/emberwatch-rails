class TalkPolicy < ApplicationPolicy
  def permitted_params
    %i(title subtitle videos url slides date)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
