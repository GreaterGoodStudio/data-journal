class PhotoPolicy < ApplicationPolicy
  def destroy?
    record.member == user && record.photographable_type == "Session"
  end

  def create_data_point?
    destroy?
  end
end
