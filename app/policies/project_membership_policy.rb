class ProjectMembershipPolicy < ApplicationPolicy
  def destroy?
    moderator? && !project.archived?
  end

  def promote?
    moderator? && !project.archived?
  end

  def demote?
    moderator? && !project.archived?
  end

  def reinvite?
    moderator? && !project.archived?
  end
end
