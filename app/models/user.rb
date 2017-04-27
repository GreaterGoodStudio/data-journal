class User < ApplicationRecord  
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable, :invitable

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
end
