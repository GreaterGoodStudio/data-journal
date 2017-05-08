class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable, :invitable

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  mount_uploader :avatar, AvatarUploader

  has_many :memberships, class_name: "ProjectMembership"
  has_many :projects, through: :memberships
  has_many :sessions
  has_many :data_points
  has_many :photos
  has_many :consent_forms

  def moderates?(project)
    project.memberships.find_by(member: self, moderator: true).present?
  end

  private

    def crop_avatar
      avatar.recreate_versions!(:thumb) if crop_x.present?
    end
end
