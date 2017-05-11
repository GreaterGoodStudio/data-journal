class PhotoUploader < BaseUploader
  include CarrierWaveDirect::Uploader

  version :thumb do
    process :crop
    process resize_to_fill: [200, 200]
  end

  version :square do
    process :crop
    process resize_to_fill: [500, 500]
  end

  version :large do
    process resize_to_limit: [500, 500]
  end

  def crop
    if model.crop_x.present?
      width = MiniMagick::Image.open(url)[:width]
      ratio = width / 500.0
      w = model.crop_w.to_f * ratio
      h = model.crop_h.to_f * ratio
      x = model.crop_x.to_f * ratio
      y = model.crop_y.to_f * ratio

      resize_to_limit(width, width)
      manipulate! do |img|
        img.crop "#{w}x#{h}+#{x}+#{y}"
      end
    end
  end

  def default_url(*_args)
    "http://placehold.it/500x500?text=placeholder" if Rails.env.development?
  end
end
