class ProjectPolicy < ApplicationPolicy
  def new?
    admin?
  end

  def show?
    admin? || record.members.exists?(user)
  end

  def archive?
    admin? && !record.archived?
  end

  def unarchive?
    admin? && record.archived?
  end

  def moderator?
    admin? || user.moderates?(record)
  end

  class Scope < Scope
    def resolve
      if admin?
        scope
      else
        scope.joins(:memberships).where("project_memberships.user_id = ?", user.id)
      end
    end
  end
end
