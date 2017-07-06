class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    member?
  end

  def new?
    admin?
  end

  def edit?
    moderator?
  end

  def download?
    member?
  end

  def archive?
    moderator? && !record.archived?
  end

  def unarchive?
    moderator? && record.archived?
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
