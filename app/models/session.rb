class Session < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  belongs_to :project, counter_cache: true, touch: true
  belongs_to :member, class_name: "User", foreign_key: :user_id

  has_many :photos, as: :photographable, dependent: :destroy
  has_many :consent_forms, dependent: :destroy
  has_many :data_points, dependent: :destroy do
    def with_member_bookmarks
      where(bookmark_member: true)
    end

    def with_moderator_bookmarks
      where(bookmark_moderator: true)
    end

    def recent(limit, starting_id = nil)
      query = order(id: :desc).limit(limit)
      query = query.where("id < ?", starting_id) unless starting_id.nil?
      query
    end
  end

  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :date, presence: true

  private

    def should_generate_new_friendly_id?
      true
    end
end
