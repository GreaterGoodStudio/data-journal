class ConsentFormPolicy < ApplicationPolicy
  def index?
    member?
  end

  def new?
    member?
  end

  def show?
    member?
  end

  def destroy?
    owner?
  end

  def download?
    member?
  end
end
