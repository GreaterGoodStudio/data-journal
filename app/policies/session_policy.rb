class SessionPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    admin? || user.moderates?(record.project)
  end

  def upload?
    record.member == user
  end

  class Scope < Scope
    def resolve
      scope.where(member: user)
    end
  end
end
