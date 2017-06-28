class ConsentFormPolicy < ApplicationPolicy
  def destroy?
    record.member == user
  end

  def download?
    destroy? || moderator?
  end

  def moderator?
    admin? || user.moderates?(record.session.project)
  end
end
