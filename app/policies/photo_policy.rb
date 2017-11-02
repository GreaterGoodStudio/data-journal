class PhotoPolicy < ApplicationPolicy
  def index?
    member?
  end

  def new?
    member? && !project.archived?
  end

  def show?
    member?
  end

  def destroy?
    owner? && !project.archived?
  end

  def download?
    owner? || moderator?
  end
end
