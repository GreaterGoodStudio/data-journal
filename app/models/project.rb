class Project < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  attr_accessor :invitees

  has_many :memberships, class_name: "ProjectMembership", dependent: :destroy
  has_many :members, through: :memberships
  has_many :sessions, dependent: :destroy do
    def for_member(member)
      where(member: member)
    end
  end
  has_many :data_points, through: :sessions

  validates :name, presence: true, uniqueness: true
  validates :due_date, presence: true
  validate :invitees_must_be_valid_emails

  def self.build
    project = self.new
    project.memberships.build.build_member
    project
  end

  private

    def invitees_must_be_valid_emails
      return if invitees.blank?

      invitees.each do |email|
        errors[:invitees] << "#{email} is an invalid email" unless email =~ EMAIL_REGEX
      end
    end

    def should_generate_new_friendly_id?
      true
    end
end
