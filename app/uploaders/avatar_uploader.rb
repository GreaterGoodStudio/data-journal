class AvatarUploader < BaseUploader
  storage :fog

  version :thumb do
    process :crop
    process resize_to_fill: [100, 100]
  end

  version :large do
    process resize_to_fit: [600, 600]
  end

  def crop
    if model.crop_x.present?
      width = MiniMagick::Image.open(url)[:width]
      ratio = width / 600.0
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

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_args)
    ActionController::Base.helpers.asset_path "default_avatar.png"
  end
end
