class DataPointPolicy < ApplicationPolicy
  def index?
    member?
  end

  def new?
    member? && session.photos.any? && !project.archived?
  end

  def show?
    member?
  end

  def edit?
    owner? && !project.archived?
  end

  def destroy?
    owner? && !project.archived?
  end

  def download?
    member?
  end

  def bookmark?
    (bookmark_member? || bookmark_moderator?) && !project.archived?
  end

  def unbookmark?
    bookmark?
  end

  def bookmark_member?
    owner? && !moderator?
  end

  def bookmark_moderator?
    moderator?
  end
end
