class SessionPolicy < ApplicationPolicy
  def show?
    ProjectPolicy.new(user, record.project).show?
  end

  def edit?
    admin? || user.moderates?(record.project)
  end

  def upload?
    record.member == user
  end

  def download?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(member: user)
    end
  end
end
