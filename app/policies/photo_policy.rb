class PhotoPolicy < ApplicationPolicy
  def destroy?
    record.member == user && record.photographable_type == "Session"
  end
end
