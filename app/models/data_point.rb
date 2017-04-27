class DataPoint < ApplicationRecord
  belongs_to :session, touch: true
  belongs_to :photo
  has_one :member, through: :session
  has_one :project, through: :session

  validates :photo, presence: true
end
