class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :member, class_name: "User", foreign_key: :user_id

  scope :moderators, -> { where(moderator: true) }
  scope :accepted, -> { joins(:member).merge(User.invitation_accepted.order(:name)) }
  scope :pending, -> { joins(:member).merge(User.invitation_not_accepted.order(:email)) }
end
