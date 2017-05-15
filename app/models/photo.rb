class Photo < ApplicationRecord
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_image

  has_ancestry orphan_strategy: :rootify
  mount_uploader :image, PhotoUploader

  belongs_to :photographable, polymorphic: true
  default_scope { order(created_at: :desc) }

  def member
    self.photographable.member
  end

  def save_and_process(options = {})
    if options[:now]
      self.remote_image_url = image.direct_fog_url(with_path: true)
      self.image_processed = true
      save!
      broadcast_update
    else
      if save
        broadcast_update
        PhotoWorker.perform_async(id)
      end
    end
  end

  private

    def broadcast_update
      SessionChannelWorker.perform_async(photographable_id, "Photo", self.id) if photographable_type == "Session"
    end

    def crop_image
      image.recreate_versions!(:thumb, :square) if crop_x.present?
    end
end
