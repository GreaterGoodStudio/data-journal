class PhotoPolicy < ApplicationPolicy
  def destroy?
    record.member == user && record.photographable_type == "Session"
  end

  def create_data_point?
    destroy?
  end

  # TODO: Moderators should be download photos too
  def download?
    destroy? || moderator?
  end

  def moderator?
    admin? || (record.photographable_type == "Session" && user.moderates?(record.photographable.project))
  end
end
