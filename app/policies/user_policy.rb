class UserPolicy < ApplicationPolicy
  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      user.try(:has_role?, :admin) ? scope : scope.where(id: user.try(:id))
    end
  end
end
