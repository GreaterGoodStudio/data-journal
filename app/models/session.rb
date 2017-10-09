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
      query = order(id: :desc)

      # Always return the limit if we can
      last_ids = query.last(limit).pluck(:id)
      starting_id = last_ids.first if last_ids.include?(starting_id.to_i)

      query = query.where("id <= ?", starting_id) unless starting_id.nil?
      query.limit(limit)
    end
  end

  validates :name, presence: true
  validates :date, presence: true

  private

    def should_generate_new_friendly_id?
      true
    end
end
