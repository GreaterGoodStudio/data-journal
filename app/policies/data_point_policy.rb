class DataPointPolicy < ApplicationPolicy
  def new?
    record.member == user
  end

  def show?
    true
  end

  def edit?
    new?
  end

  def destroy?
    new?
  end

  def bookmark?
    bookmark_member? || bookmark_moderator?
  end

  def unbookmark?
    bookmark?
  end

  def bookmark_member?
    !bookmark_moderator? && record.member == user
  end

  def bookmark_moderator?
    admin? || user.moderates?(record.project)
  end
end
