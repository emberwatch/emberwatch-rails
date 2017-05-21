class BookPolicy < ApplicationPolicy

  def permitted_params
    %i(title publisher url payment)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
