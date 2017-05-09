class DataPoint < ApplicationRecord
  belongs_to :session, touch: true
  has_one :member, through: :session
  has_one :project, through: :session
  has_one :photo, as: :photographable, dependent: :destroy

  validates :observation, presence: true, length: { maximum: 250 }
  validates :meaning, length: { maximum: 115 }
end
