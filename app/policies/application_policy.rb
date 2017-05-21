class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.try(:has_role?, :admin)
  end

  def update?
    user.try(:has_role?, :admin)
  end

  def destroy?
    user.try(:has_role?, :admin)
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def permitted_params
    %i()
  end

  def whitelisted_params
    %i()
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
