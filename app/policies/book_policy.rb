class BookPolicy < ApplicationPolicy

  def permitted_params
    %i(id title publisher url payment)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
