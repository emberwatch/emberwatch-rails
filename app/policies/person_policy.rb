class PersonPolicy < ApplicationPolicy
  def permitted_params
    %i(
      old_id shortname name github slack twitter slideshare speakerdeck site
      company
    )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
