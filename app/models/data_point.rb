class DataPoint < ApplicationRecord
  attr_accessor :croppable_photo_id, :crop_x, :crop_y, :crop_w, :crop_h
  after_save :crop_and_save_photo

  belongs_to :session, counter_cache: true, touch: true
  has_one :member, through: :session
  has_one :project, through: :session
  has_one :photo, as: :photographable, dependent: :destroy

  validates :croppable_photo_id, presence: true, unless: -> { photo.present? }
  validates :observation, presence: true, length: { maximum: 250 }
  validates :meaning, length: { maximum: 115 }

  private

    def crop_and_save_photo
      return unless croppable_photo_id.present?

      croppable_photo = Photo.find(croppable_photo_id)
      create_photo!(remote_image_url: croppable_photo.image_url, parent: croppable_photo)
      photo.update_attributes crop_x: crop_x, crop_y: crop_y, crop_w: crop_w, crop_h: crop_h
    end
end
