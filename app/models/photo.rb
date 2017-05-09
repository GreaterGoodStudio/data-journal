class Photo < ApplicationRecord
  has_ancestry
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
    else
      PhotoWorker.perform_async(id) if save
    end

    SessionChannelWorker.perform_async(photographable_id, "Photo", self.id) if photographable_type == "Session"
  end
end
