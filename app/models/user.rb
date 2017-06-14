class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable, :invitable

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :eula

  after_update :crop_avatar

  mount_uploader :avatar, AvatarUploader

  has_many :memberships, class_name: "ProjectMembership"
  has_many :projects, through: :memberships
  has_many :sessions
  has_many :data_points
  has_many :photos
  has_many :consent_forms

  validates :avatar, presence: true
  validates :eula, acceptance: true, if: :requires_eula? && :accepting_invitation?

  def moderates?(project)
    project.memberships.find_by(member: self, moderator: true).present?
  end

  private

    def crop_avatar
      avatar.recreate_versions!(:thumb) if crop_x.present?
    end

    def requires_eula?
      Rails.application.secrets.eula_url.present?
    end
end
