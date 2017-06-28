class SessionPolicy < ApplicationPolicy
  def show?
    ProjectPolicy.new(user, record.project).show?
  end

  def edit?
    moderator?
  end

  def upload?
    record.member == user
  end

  def download?
    show?
  end

  def moderator?
    admin? || user.moderates?(record.project)
  end

  class Scope < Scope
    def resolve
      scope.where(member: user)
    end
  end
end
