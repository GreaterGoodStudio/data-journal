class PhotoWorker
  include Sidekiq::Worker
  sidekiq_options queue: "photos"

  def perform(id)
    photo = Photo.find(id)
    photo.save_and_process(now: true)
  end
end
