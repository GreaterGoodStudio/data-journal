class SessionPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member?
  end

  def new?
    member? && !project.archived?
  end

  def edit?
    owner? && !project.archived?
  end

  def upload?
    owner? && !project.archived?
  end

  def download?
    member?
  end

  class Scope < Scope
    def resolve
      scope.where(member: user)
    end
  end
end
