class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader

  belongs_to :session
  has_many :data_points
  has_one :member, through: :session

  default_scope { order(created_at: :desc) }

  def save_and_process(options = {})
    if options[:now]
      self.remote_image_url = image.direct_fog_url(:with_path => true)
      self.image_processed = true
      save!
    else
      PhotoWorker.perform_async(id) if save
    end

    SessionChannelWorker.perform_async session_id, "Photo", self.id
  end
end
