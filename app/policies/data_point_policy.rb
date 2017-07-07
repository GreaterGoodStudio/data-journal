class DataPointPolicy < ApplicationPolicy
  def index?
    member?
  end

  def new?
    member?
  end

  def show?
    member?
  end

  def edit?
    owner?
  end

  def destroy?
    owner?
  end

  def download?
    member?
  end

  def bookmark?
    bookmark_member? || bookmark_moderator?
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
