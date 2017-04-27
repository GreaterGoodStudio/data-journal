class PhotoPolicy < ApplicationPolicy
  def destroy?
    record.member == user && record.data_points.empty?
  end
end