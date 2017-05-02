class DataPoint < ApplicationRecord
  belongs_to :session, touch: true
  belongs_to :photo
  has_one :member, through: :session
  has_one :project, through: :session

  validates :photo_id, presence: true
  validates :observation, presence: true, length: { maximum: 250 }
  validates :meaning, length: { maximum: 115 }
end
