class ConsentFormPolicy < ApplicationPolicy
  def destroy?
    record.member == user
  end
end
