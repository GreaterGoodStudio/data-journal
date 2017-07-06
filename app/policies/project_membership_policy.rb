class ProjectMembershipPolicy < ApplicationPolicy
  def destroy?
    moderator?
  end

  def promote?
    moderator?
  end

  def demote?
    moderator?
  end

  def reinvite?
    moderator?
  end
end
