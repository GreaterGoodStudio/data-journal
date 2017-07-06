class SessionPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member?
  end

  def new?
    member?
  end

  def edit?
    owner?
  end

  def upload?
    owner?
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
