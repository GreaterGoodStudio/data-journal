class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog
  
  version :thumb do
    process :crop
    process resize_to_fill: [100, 100]
  end

  version :large do
    process resize_to_limit: [600, 600]
  end

  def crop
    if model.crop_x.present?
      resize_to_limit(600, 600)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop "#{model.crop_w}x#{model.crop_h}+#{model.crop_x}+#{model.crop_y}"
      end
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_args)
    ActionController::Base.helpers.asset_path "default_avatar.png"
  end

  def fog_public
    false
  end
end
