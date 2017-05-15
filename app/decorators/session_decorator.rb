class SessionDecorator < BaseDecorator
  decorates_association :member

  def thumbnail
    image_tag thumbnail_image, class: "ui image"
  end

  def formatted_date
    object.date.strftime("%m/%d/%Y")
  end

  private

    def thumbnail_image
      object.photos.any? ? object.photos.last.image_url(:thumb) : asset_url("default_photo.png")
    end
end
